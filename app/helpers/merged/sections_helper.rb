module Merged
  module SectionsHelper
    include ViewHelper #for previews

    #image tag for the preview, passing options through
    def section_preview(section , options)
      image_tag("merged/section_preview/#{section.template}" , options)
    end

    def card_preview(section , options)
      image_tag("merged/card_preview/#{section.card_template}" , options)
    end
  end
end
