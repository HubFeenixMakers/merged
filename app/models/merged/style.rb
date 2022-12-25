module Merged
  class Style < ActiveBase

    set_root_path Engine.root + "config"

    fields  :options

    def options_definitions
      option_defs = []
      options.each do |name|
        option = OptionDefinition.find_by_name(name)
        raise "no option for #{name}:#{name.class}" if option.blank?
        option_defs << option
      end if options
      option_defs
    end

  end
end
