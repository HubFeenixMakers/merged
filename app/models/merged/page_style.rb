module Merged
  class PageStyle < Style
    fields  :type , :description , :section_template

    def section_preview
      "merged/section_preview/" + section_template
    end

  end
end
