module Merged
  module ViewHelper
    include MergedHelper

    def rows( text )
      return 5 if text.blank?
      text = text.text unless text.is_a?(String)
      rows = (text.length / 60).to_i
      return 5 if rows < 5
      rows
    end

    # background image as inline style
    def bg(section , clazz = "")
      return {class: clazz} if section.image.blank?
      img = asset_url( section.image.asset_name )
      style = "background-image: url('#{img}');"
      if(section.option("fixed") == "on")
        clazz += " bg-fixed"
      end
      if(align = section.option("image_align"))
        align += "-bottom" unless align == "center"
        # for tailwind: bg-left-bottom bg-right-bottom bg-center
        clazz += " bg-#{align}"
      end
      {class: clazz , style: style}
    end

    # works for with sections and cards that respond to .image
    def image_for(element , classes = "")
      return "" if element.image.blank?
      image = element.image
      image_tag(image.asset_name , alt: image.name , class: classes )
    end

  end
end
