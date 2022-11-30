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
      @cards = {}
      element = @content["cards"]
      return if element.nil?
      element.each do|card_content|
        card = Card.new(self , card_content)
        @cards[card.id] = card
      end
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

    def template
      @content["template"]
    end
    def card_template
      @content["card_template"]
    end

    def id
      @content["id"]
    end

    def save
      raise "Called"
    end

    def self.find(page_name , section_id)
      raise "buggy"
      Page.new(name + ".yaml")
    end

  end
end
