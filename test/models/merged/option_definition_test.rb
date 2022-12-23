require "test_helper"

module Merged
  class OptionDefinitionTest < ActiveSupport::TestCase

    def first
      OptionDefinition.first
    end

    def test_has_first
      assert_equal OptionDefinition.first.class ,  OptionDefinition
    end
    def test_there_options
      assert_equal OptionDefinition.all.length ,  18
    end
    def test_has_option_objects
      assert_equal first.class ,  OptionDefinition
    end
    def test_has_values
      assert_equal first.values.class ,  Array
    end
  end
end
