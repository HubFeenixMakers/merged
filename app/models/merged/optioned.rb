module Merged
  #relies only on @content["options"]
  #and a method template_style
  module Optioned
    def has_option?(option)
      options.has_key?(option)
    end

    def option_definitions
      template_style.options
    end

    def option(name)
      options[name]
    end

    def options
      @content["options"] || {}
    end

    def set_option( option , value)
      puts "#{template_style} setting option #{option}=#{value.class}"
      @content["options"] = {} if @content["options"].nil?
      options[option] = value
    end

  end
end
