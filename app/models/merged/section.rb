module Merged
  class Section < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary

    include ActiveHash::Associations
    belongs_to :page , class_name: "Merged::Page"

    include Optioned

    fields :name , :page_id , :index , :cards , :options
    fields :template , :card_template , :id , :text , :header, :image

    def cards
      Card.where(section_id: id).order(index: :asc)
    end

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


    def move_up
      swap_index_with(next_section)
    end

    def move_down
      swap_index_with(previous_section)
    end

    def previous_section
      page.sections.where(index: index - 1).first
    end

    def next_section
      page.sections.where(index: index + 1).first
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
