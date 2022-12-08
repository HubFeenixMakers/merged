module Merged
  class Card
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    include Optioned

    cattr_reader :all
    @@all = {}

    attr_reader  :content  , :index , :section

    [ :id , :text , :header, :image ].each do |meth|
      define_method(meth) do
        @content[meth.to_s]
      end
    end

    def initialize(section , index , card_data)
      @section = section
      @index = index
      raise "No data #{card_data}" unless card_data.is_a?(Hash)
      @content = card_data
      raise "No id #{card_data}" unless id.is_a?(String)
      @@all[self.id] = self
    end

    def template_style
      @section.card_template
    end

    def destroy
      @section.remove_card( self)
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

    def move_up
      @section.move_card_up(self)
    end
    def move_down
      @section.move_card_down(self)
    end

    def save
      section.save
    end

    def set_index(index)
      @index = index
    end

    def template_style
      CardStyle.cards[ section.card_template ]
    end
    def allowed_fields
      template_style.fields
    end

    def self.build_data(card_template)
      data = { "id" => SecureRandom.hex(10) }
      CardStyle.cards[ card_template ].fields.each do |key|
        data[key] = key.upcase
      end
      data
    end

    def self.find_card(id)
      raise "nil given" if id.blank?
      card = @@all[id]
      raise "Section not found #{id}" unless card
      return card
    end
  end
end
