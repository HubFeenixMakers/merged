module Merged
  class Option

    attr_reader :name , :default , :description

    def initialize(options)
      @name = options["name"]
      @default = options["default"]
      @description = options["description"]
      @values = options["values"]
    end

    def type
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
  end
end
