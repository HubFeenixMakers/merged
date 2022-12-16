module Merged

  # base class for viewable elements: ie page, section and casrd
  # they share the template idea, options , change tracking,
  # and the fact that they persist in ActiveYaml

  class ViewBase < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary
    include ActiveHash::Associations

    fields :options , :updated_at , :updated_by

    def has_option?(option)
      options.has_key?(option) and !options[option].blank?
    end

    def option_definitions
      template_style.options_definitions
    end

    def option(name)
      options[name]
    end

    def options
      return attributes[:options] unless attributes[:options].blank?
      attributes[:options] = {}
    end

    def set_option( option , value)
      options[option] = value
    end

    def add_default_options( definitions = nil )
      definitions = option_definitions if definitions.nil?
      definitions.each do |option|
        next unless option.default
        set_option( option.name , option.default)
      end
    end

    def update(key , value)
      raise "unsuported field #{key} for #{template}" unless allowed_fields.include?(key)
      if(! attributes[key].nil? ) # first setting ok, types not (yet?) specified
        if( @attributes[key].class != value.class )
          raise "Type mismatch #{key} #{key.class}!=#{value.class}"
        end
      end
      attributes[key] = value
    end

    #other may be nil
    def swap_index_with(other)
      return unless other
      old_index = self.index
      self.index = other.index
      other.index = old_index
    end

    def allowed_fields
      template_style.fields.collect{|f| f.to_sym}
    end

  end
end
