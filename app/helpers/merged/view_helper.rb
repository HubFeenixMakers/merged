module Merged
  module ViewHelper
    # section should be hash with at least 'template' key
    def find_template(section)
      "sections/" + section["template"]
    end

    def bg(section)
      #{'background-image' => url('#{image_url('merge/' + section['image'])}')}
      img = image_url "merge/house.jpg"
      "background-image: url('#{img}');"
    end
    def image_for(section , classes)
      image_tag("merge/#{section['image']}" , class: classes)
    end
    def has_button(section)
      section['button']
    end
  end
end
