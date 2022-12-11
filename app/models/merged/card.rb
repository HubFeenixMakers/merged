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

    def move_up
      swap_index_with(next_card)
    end

    def move_down
      swap_index_with(previous_card)
    end

    def previous_card
      section.cards.where(index: index - 1).first
    end

    def next_card
      section.cards.where(index: index + 1).first
    end

    def save
      super
      data = Card.all.collect {|obj| obj.attributes}
      File.write( Card.full_path , data.to_yaml)
    end

    def set_index(index)
      @index = index
    end

    def template_style
      CardStyle.find_by_template( section.card_template)
    end

    def self.new_card(card_template , section_id , index)
      data = { section_id: section_id , index: index}
      CardStyle.find_by_template( card_template ).fields.each do |key|
        data[key] = "NEW"
      end
      card = Card.new(data)
      card.add_default_options
      card
    end

  end
end
