module Merged
  class SectionStyle < Style
    
    fields  :template , :text , :header, :fields , :cards

    def has_cards?
      cards
    end

    def section_preview
      "merged/section_preview/" + template
    end

  end
end
