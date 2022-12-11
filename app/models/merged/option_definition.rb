module Merged
  class OptionDefinition < ActiveYaml::Base
    set_root_path Engine.root + "config"

    fields :name , :default , :description , :values , :type

    def type
      return attributes[:type] unless attributes[:type].blank?
      if has_values?
        "select"
      else
        "text"
      end
    end

    def has_values?
      return false if attributes[:values].nil?
      ! attributes[:values].empty?
    end

    def values
      return [] unless has_values?
      attributes[:values].split(" ")
    end

  end
end
