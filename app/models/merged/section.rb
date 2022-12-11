module Merged
  class Section < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary

    include ActiveHash::Associations
    belongs_to :page , class_name: "Merged::Page"
    has_many :cards , class_name: "Merged::Card" , scope:  -> { order(index: :desc) }


    include Optioned

    fields :name , :page_id , :index , :cards , :options
    fields :template , :card_template , :id , :text , :header, :image

    def set_template(new_template)
      self.template = new_template
      new_style = template_style
      if(new_style.has_cards?)
        unless card_template
          self.card_template = CardStyle.first.name
        end
      else
        cards.delete_all
      end
    end

    def template_style
      SectionStyle.find_by_template( template )
    end

    def allowed_fields
      template_style.fields
    end

    def has_cards?
      ! card_template.blank?
    end

    def new_card
      card_data = Card.build_data(card_template)
      index = cards.length
      card = Card.new(self , index,  card_data)
      @cards << card
      @content["cards"] << card_data
      card
    end

    def remove_card(card)
      from_index = card.index
      @cards.delete_at(from_index)
      @content["cards"].delete_at(from_index)
      @cards.each_with_index do |card, index|
        card.set_index(index)
      end
    end

    def destroy
      @page.remove_section(self)
    end

    def move_up
      @page.move_section_up(self)
    end

    def move_down
      @page.move_section_down(self)
    end

    def previous_section
      page.sections.where(index: index - 1).first
    end

    def next_section
      page.sections.where(index: index + 1).first
    end

    def move_card_up(card)
      return if cards.length == 1
      return if card.index == 0
      swap( card , cards[card.index - 1])
    end

    def move_card_down(card)
      return if cards.length == 1
      return if card.index == cards.last.index
      swap( card , cards[card.index + 1])
    end

    def swap( this_card , that_card)
      # swap in the actual objects, index is cached in the objects
      this_old_index = this_card.index
      this_card.set_index( that_card.index )
      that_card.set_index( this_old_index )

      # swap in the cards cache
      cards[ this_card.index ] = this_card
      cards[ that_card.index ] = that_card
      # swap in the yaml
      card_content = content["cards"]
      card_content[this_card.index] = this_card.content
      card_content[that_card.index] = that_card.content
    end

    def update(key , value)
      raise "unsuported field #{key} for #{template}" unless allowed_fields.include?(key)
      if(! @content[key].nil? ) # first setting ok, types not (yet?) specified
        if( @content[key].class != value.class )
          raise "Type mismatch #{key} #{key.class}!=#{value.class}"
        end
      end
      @content[key] = value
    end

    def save
      super
      data = Section.all.collect {|obj| obj.attributes}
      File.write( Section.full_path , data.to_yaml)
    end

    def set_index(index)
      @index = index
    end

    def self.build_data(template)
      data = { "template" => template , "id" => SecureRandom.hex(10) }
      style = SectionStyle.sections[ template ]
      style.fields.each do |key|
        data[key] = key.upcase
      end unless style.fields.blank?
      if(style.has_cards?)
        data["cards"] = []
        data["card_template"] = CardStyle.first.name
      end
      data
    end

  end
end
