module Merged
  module ViewHelper
    include MergedHelper
    # section should be hash with at least 'template' key
    def find_template(section)
      "merged/view/" + section.template
    end

    # background image as inline style
    def bg(section)
      return "" if section.image.blank?
      puts "--#{Image.image_root}/#{section.image}--"
      img = asset_url( "#{Image.image_root}/#{section.image}" )
      "background-image: url('#{img}');"
    end

    # works for with sections and cards that respond to .image
    def image_for(element , classes)
      return "" if element.image.blank?
      image_tag("#{Image.image_root}/#{element.image}" , class: classes)
    end

  end
end
