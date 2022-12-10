module Merged
  class Card < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary

    include ActiveHash::Associations
    belongs_to :section , class_name: "Merged::Section"

    include Optioned

    fields  :index , :section_id,  :id , :text , :header, :image

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
      super
      data = Card.all.collect {|obj| obj.attributes}
      File.write( Option.full_path , data.to_yaml)
    end

    def set_index(index)
      @index = index
    end

    def template_style
      CardStyle.find_by_template( section.card_template)
    end

    def allowed_fields
      template_style.fields
    end

    def self.build_data(card_template)
      data = { "id" => SecureRandom.hex(10) }
      CardStyle.find_by_template( card_template ).fields.each do |key|
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
