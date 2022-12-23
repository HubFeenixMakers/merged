require "test_helper"

module Merged
  class SectionTest < ActiveSupport::TestCase
    include SectionHelper

    def test_has_all
      assert_equal Section.all.length ,  14
    end
    def test_has_index_page
      assert_equal last.class ,  Section
    end
    def test_has_index
      assert_equal last.index ,  10
    end
    def test_has_cards
      assert_equal last.cards.length ,  5
    end
    def test_has_cards_array
      assert_equal last.cards.class ,  ActiveHash::Relation
    end
    def test_has_options
      assert_equal last.options.class ,  Hash
      assert_equal first.options.length ,  4
    end
    def test_has_option_definitions
      assert_equal last.option_definitions.class ,  Array
      assert_equal last.option_definitions.length ,  4
      assert_equal last.option_definitions.second.class ,  OptionDefinition
      assert_equal last.option_definitions.second.name ,  "handler"
    end
    def test_last_has_previous
      assert_equal last.previous_section.index ,  9
    end
    def test_first_has_no_previous
      assert_equal first.index ,  1
      assert_nil first.previous_section
    end
    def test_first_has_next
      assert_equal first.next_section.index ,  2
    end
    def test_last_has_no_next
      assert_nil last.next_section
    end
  end
end
