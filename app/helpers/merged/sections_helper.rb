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

  end
end
