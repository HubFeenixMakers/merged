module Merged
  class Section
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    cattr_reader :all
    @@all = {}

    attr_reader :name , :content , :page , :index , :cards

    def initialize(page , index , section_data)
      @page = page
      raise "No number #{index}" unless index.is_a?(Integer)
      raise "No hash #{section_data}" unless section_data.is_a?(Hash)
      @index = index
      @content = section_data
      @@all[self.id] = self
      @cards = []
      element = @content["cards"]
      return if element.nil?
      element.each_with_index do|card_content , index|
        @cards << Card.new(self , index , card_content)
      end
    end

    [:template , :card_template , :id , :text , :header, :image, :options].each do |meth|
      define_method(meth) do
        @content[meth.to_s]
      end
    end

    [:button_link , :button_text ].each do |meth|
      define_method(meth) do
        @content["options"][meth.to_s]
      end
    end

    def has_option?(option)
      options.has_key?(option)
    end

    def option_definitions
      template_style.options
    end

    def option(name)
      options[name]
    end

    def options
      @content["options"] || {}
    end

    def set_option( option , value)
      puts "#{template} setting option #{option}=#{value.class}"
      @content["options"] = {} if @content["options"].nil?
      options[option] = value
    end

    def set_template(new_template)
      @content["template"] = new_template
      new_style = template_style
      if(new_style.cards?)
        unless card_template
          @content["card_template"] = Style.cards.keys.first
          @content["cards"] = []
          raise "Should not have cards" unless cards.empty?
        end
      else
        @content.delete("cards")
        @content.delete("card_template")
        @cards.clear
      end
    end

    def template_style
      Style.sections[ template ]
    end
    def allowed_fields
      template_style.fields
    end

    def cards?
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
      @page.move_section_up(self)
    end
    def move_down
      @page.move_section_down(self)
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
      page.save
    end

    def set_index(index)
      @index = index
    end

    def self.build_data(template)
      data = { "template" => template , "id" => SecureRandom.hex(10) }
      style = Style.sections[ template ]
      style.fields.each do |key|
        data[key] = key.upcase
      end unless style.fields.blank?
      if(style.cards?)
        data["cards"] = []
        data["card_template"] = Style.cards.keys.first
      end
      data
    end

    def self.find(section_id)
      raise "nil given" if section_id.blank?
      section = @@all[section_id]
      raise "Section not found #{section_id}" unless section
      return section
    end

  end
end
