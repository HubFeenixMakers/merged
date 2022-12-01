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

    def cards?
      ! cards.empty?
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

    def self.find(section_id)
      raise "nil given" if section_id.blank?
      section = @@all[section_id]
      raise "Section not found #{section_id}" unless section
      return section
    end

  end
end
