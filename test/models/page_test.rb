require "test_helper"

module Merged
  class PageTest < ActiveSupport::TestCase

    def index
      Page.find_by_name('index')
    end

    def test_all
      assert_equal 2 , Page.all.length
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
    def test_change_name
      assert_equal "index" , index.change_name
    end

  end
end
