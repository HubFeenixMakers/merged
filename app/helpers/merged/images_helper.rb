module Merged

  module ImagesHelper

    def text_for_index
      if(section_id)
        section = Section.find(section_id)
        "Select image for Section #{section.index} : #{section.header}"
      elsif(card_id)
        card = Card.find(card_id)
        "Select image for Card #{card.index} : #{card.header}"
      else
        "All Images"
      end
    end

    def text_for_new
      if(section_id)
        section = Section.find(section_id)
        "Add image for Section"
      elsif(card_id)
        card = Card.find(card_id)
        "Select image for Card"
      else
        "New Image"
      end
    end

    def hidden_for_select
      if(section_id)
        hidden_field_tag :section_id , section_id
      elsif(card_id)
        hidden_field_tag :card_id , card_id
      else
        ""
      end
    end

    private
    def section_id
      params[:section_id]
    end
    def card_id
      params[:card_id]
    end

  end
end
