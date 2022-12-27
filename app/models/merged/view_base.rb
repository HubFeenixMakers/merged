module Merged

  # base class for viewable elements: ie page, section and casrd
  # they share the template idea, options , change tracking,
  # and the fact that they persist in ActiveYaml

  class ViewBase < ActiveBase
    set_root_path Rails.root #ouside engines not necessary
    include ActiveHash::Associations

    belongs_to :image , class_name: "Merged::Image"

    fields :options

    def last_update_for(elements)
      last = Time.now
      last_section = nil
      elements.each do |section|
        if( section.updated_at < last )
          last = section.updated_at
          last_section = section
        end
      end
      last_section
    end


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

    def image_old
      Image.find_by_name(self.image_name)
    end
  end
end
