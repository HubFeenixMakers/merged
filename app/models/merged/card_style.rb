module Merged
  class CardStyle < Style
    
    fields  :template , :text , :header, :fields

    def card_preview
      "merged/card_preview/" + template
    end

  end
end
