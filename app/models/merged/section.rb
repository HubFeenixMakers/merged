module Merged
  class Section
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_reader :name , :content , :page , :index

    def persisted?
      false
    end

    def initialize(page , index , section_data)
      @page = page
      raise "No number #{index}" unless index.is_a?(Integer)
      raise "No has #{section_data}" unless section_data.is_a?(Hash)
      @index = index
      @content = section_data
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

    def self.all
      @page.sections
    end

    def self.find(page_name , section_id)
      raise "buggy"
      Page.new(name + ".yaml")
    end

  end
end
