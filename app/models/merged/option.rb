module Merged
  class Option

    @@options = {}

    attr_reader :name , :default , :description

    def initialize(options)
      @name = options["name"]
      @default = options["default"]
      @description = options["description"]
      @values = options["values"]
      @type = options["type"]
    end

    def type
      return @type unless @type.blank?
      if has_values?
        "select"
      else
        "text"
      end
    end

    def has_values?
      return false if @values.nil?
      ! @values.empty?
    end

    def values
      return [] unless has_values?
      @values.split(" ")
    end

    def self.options
      @@options
    end

    def self.load(yaml)
      yaml.each do |content|
        option = Option.new(content)
        @@options[option.name] = option
      end
    end

  end
end
