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

    [:template , :card_template , :id , :text , :header, :image].each do |meth|
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

    def options
      @content["options"] || {}
    end

    def set_option( option , value)
      @content["options"] = {} if @content["options"].nil?
      options[option] = value
    end

    def cards?
      ! cards.empty?
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
      return if key == "id" #not updating that
      if(! @content[key].nil? )
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

    def self.find(section_id)
      raise "nil given" if section_id.blank?
      section = @@all[section_id]
      raise "Section not found #{section_id}" unless section
      return section
    end

  end
end
