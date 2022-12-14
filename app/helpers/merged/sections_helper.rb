module Merged
  module SectionsHelper
    include ViewHelper #for previews

    def section_form(options)
      url = section_url( @section.id)
      form_tag( url , {method: :patch}) do
        yield
      end
    end

    #image tag for the preview, passing options through
    def section_preview(section , options)
      image_tag("merged/section_preview/#{section.template}" , options)
    end

    def card_preview(section , options)
      image_tag("merged/card_preview/#{section.card_template}" , options)
    end
  end
end
