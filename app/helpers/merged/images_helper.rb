module Merged

  module ImagesHelper

    def text_for_index
      return section_text if(section_id)
      return card_text if(card_id)
      "All Images"
    end


    private
    def section_id
      params[:section_id]
    end
    def card_id
      params[:card_id]
    end
    def section_text
      section = Section.find(section_id)
      "Select image for Section #{section.index} : #{section.header}"
    end
    def card_text
      card = Card.find(card_id)
      "Select image for Card #{card.index} : #{card.header}"
    end


  end
end
