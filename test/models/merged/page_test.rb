require "test_helper"

module Merged
  class PageTest < ActiveSupport::TestCase

    def index
      Page.find_by_name('index')
    end

    def test_all
      assert_equal 2 , Page.all.length
    end
    def test_creates_page
      name = "randomname"
      page = Page.new_page( name)
      assert_equal page.name , name
    end

    def test_has_type
      assert_equal index.type ,  "page"
    end

    def test_has_index_page
      assert_equal index.class ,  Page
    end
    def test_has_sections
      assert_equal index.sections.length ,  10
    end
    def test_has_section_array
      assert_equal index.sections.first.class ,  Section
    end
    def test_has_section_indexes
      index.sections.each_with_index do |section, index|
        assert_equal section.index ,  index + 1 # because we have human index
      end
    end
  end
end
