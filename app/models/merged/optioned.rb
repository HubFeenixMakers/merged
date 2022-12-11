module Merged
  #relies only on @content["options"]
  #and a method template_style
  module Optioned
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
      attributes[:options] || {}
    end

    def set_option( option , value)
      puts "#{template_style} setting option #{option}=#{value.class}"
      @content["options"] = {} if @content["options"].nil?
      options[option] = value
    end

  end
end
