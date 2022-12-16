module Merged
  class PageStyle < ActiveYaml::Base
    set_root_path Engine.root + "config"

    fields  :type , :description

  end
end
