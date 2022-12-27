require "test_helper"

module Merged
  class PageWriteTests < ActiveSupport::TestCase
    include Cleanup

    def index
      Page.find_by_name('index')
    end

    def test_creates_page
      name = "randomname"
      page = Page.new_page( name , "page")
      assert_equal page.name , name
      assert_equal page.sections.length , 0
    end

    def test_creates_blog
      name = "randomname"
      page = Page.new_page( name , "blog")
      assert_equal page.name , name
      page.add_save("me")
      template = PageStyle.find_by_type(page.type).section_template
      section = page.new_section(template)
      section.add_save("me")
      assert_equal page.sections.length , 1
    end

    def test_deletes
      id = index.id
      index.delete
      assert_raises(ActiveHash::RecordNotFound){Page.find(id) }
    end
    def test_destroys
      id = index.id
      index.delete
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Page.find(id) }
    end
    def test_destroys_sections
      id = index.sections.first.id
      index.delete
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Page.find(id) }
    end
    def test_creates_simple_section
      s = index.new_section("section_spacer")
      assert s
      assert_equal s.template ,  "section_spacer"
    end
    def test_creates_section_with_right_index
      should_be = index.sections.last.index + 1
      s = index.new_section("section_spacer")
      assert_equal s.index ,  should_be
    end

  end
end
