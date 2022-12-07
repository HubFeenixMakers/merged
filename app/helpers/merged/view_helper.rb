module Merged
  module ViewHelper
    include OptionsHelper
    include MergedHelper
    # section should be hash with at least 'template' key
    def find_template(section)
      "merged/view/" + section.template
    end

    # background image as inline style
    def bg(section , clazz = "")
      attributes = {class: clazz}
      return attributes if section.image.blank?
      #puts "--#{Image.image_root}/#{section.image}--"
      img = asset_url( "#{Image.image_root}/#{section.image}" )
      attributes["style"] = "background-image: url('#{img}');"
      if(section.option("fixed") == "on")
        attributes[:class] = attributes[:class] + " bg-fixed"
        puts "Adding fixed"
      end
      attributes
    end

    # works for with sections and cards that respond to .image
    def image_for(element , classes)
      return "" if element.image.blank?
      image_tag("#{Image.image_root}/#{element.image}" , class: classes)
    end

    def button(text , url , color)
      link_to(url) do
        content_tag(:button , class: color + " " + button_classes ) do
          text
        end
      end
    end

  end
end
