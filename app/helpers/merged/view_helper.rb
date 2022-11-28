module Merged
  module ViewHelper
    # section should be hash with at least 'template' key
    def find_template(section)
      "merged/view/" + section["template"]
    end

    def bg(section)
      puts "--#{Image.root}/#{section['image']}--"
      img = asset_url( "#{Image.root}/#{section['image']}" )
      "background-image: url('#{img}');"
    end
    def image_for(section , classes)
      image_tag("#{Image.root}/#{section['image']}" , class: classes)
    end
    def has_button(section)
      section['button']
    end
  end
end
