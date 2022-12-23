require "test_helper"

module Merged
  class PageTest < ActiveSupport::TestCase
    def first
      PageStyle.all.first
    end

    def test_finds_stye
      spacer = PageStyle.find_by_type("page")
      assert spacer
    end

    def test_has_sections
      assert_equal PageStyle.all.length ,  1
    end
    def test_Spacer_has_no_fields
      assert first.description
    end
  end
end
