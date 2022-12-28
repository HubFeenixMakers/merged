require "test_helper"

module Merged
  class SectionStyleTest < ActiveSupport::TestCase

    def first_section
      SectionStyle.all.first
    end

    def test_finds_stye
      spacer = SectionStyle.find_by_template("section_spacer")
      assert spacer
    end
    def test_has_sections
      assert_equal SectionStyle.all.length ,  9
    end
    def test_finds_section_by_template
      spacer = SectionStyle.find_by_template("section_spacer")
      assert spacer
    end
    def test_Spacer_has_no_fields
      spacer = SectionStyle.find_by_template("section_spacer")
      assert_nil spacer.fields
    end
  end
end
