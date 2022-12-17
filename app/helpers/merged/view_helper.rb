module Merged
  module ViewHelper
    include OptionsHelper
    include MergedHelper

    # background image as inline style
    def bg(section , clazz = "")
      attributes = {class: clazz}
      return attributes if section.image.blank?
      img = asset_url( section.image.assert_name )
      attributes["style"] = "background-image: url('#{img}');"
      if(section.option("fixed") == "on")
        attributes[:class] = attributes[:class] + " bg-fixed"
      end
      attributes
    end

    # works for with sections and cards that respond to .image
    def image_for(element , classes = "")
      return "" if element.image.blank?
      image_tag(element.image.assert_name , class: classes)
    end

  end
end
