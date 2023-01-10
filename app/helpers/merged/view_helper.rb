module Merged
  module ViewHelper
    include MergedHelper
    include PagesHelper

    def render_section(section)
      template = "merged/view/" + section.template
      render( template , section: section)
    end

    def rows( text )
      return 5 if text.blank?
      text = text.text unless text.is_a?(String)
      return 5 if text.blank?
      rows = (text.length / 50).to_i
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
