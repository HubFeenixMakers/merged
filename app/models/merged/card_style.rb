module Merged
  class CardStyle < ActiveYaml::Base
    set_root_path Engine.root + "config"

    fields  :template , :text , :header, :fields

    def card_preview
      "merged/card_preview/" + template
    end

    def options_definitions
      option_defs = []
      options.each do |name|
        option = Option.find_by_name(name)
        raise "no option for #{name}:#{name.class}" if option.blank?
        option_defs << option
      end if options
      option_defs
    end

  end
end
