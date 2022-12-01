module Merged
  module SectionsHelper

    def section_form(options)
      url = section_url( @section.id)
      form_tag( url , {method: :patch}) do
        yield
      end
    end

    def image_root
      Image.image_root
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
