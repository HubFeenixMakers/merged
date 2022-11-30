module Merged
  class Card
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    cattr_reader :all
    @@all = {}

    attr_reader  :content  , :index , :section

    def initialize(section , index , card_data)
      @section = section
      @index = index
      raise "No data #{card_data}" unless card_data.is_a?(Hash)
      @content = card_data
      raise "No id #{card_data}" unless id.is_a?(String)
      @@all[self.id] = self
    end

    def id
      @content['id']
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
      section.save
    end

    def self.find_card(id)
      raise "nil given" if id.blank?
      card = @@all[id]
      raise "Section not found #{id}" unless card
      return card
    end
  end
end
