require "test_helper"

module Merged
  class PageTest < ActiveSupport::TestCase
    def first_card
      CardStyle.all.first
    end

    def test_has_all
      assert CardStyle.all.length > 5
    end

    def test_has_fields
      assert_equal first_card.fields.class ,  Array
      assert_equal first_card.fields.length ,  2
      assert_equal first_card.fields.first ,  "header"
    end
  end
end
