require "test_helper"

module Merged
  class PageTest < ActiveSupport::TestCase
    def first_card
      CardStyle.all.first
    end

    def test_has_all
      assert_equal CardStyle.all.length ,  6
    end

    def test_has_fields
      assert_equal first_card.fields.class ,  Array
      assert_equal first_card.fields.length ,  2
      assert_equal first_card.fields.first ,  "header"
    end
  end
end
