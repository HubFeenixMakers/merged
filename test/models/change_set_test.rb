require "test_helper"

module Merged
  module Zero
    def change
      ChangeSet.current
    end
    def setup
      change.zero
    end
  end
  class ChangeSetTest < ActiveSupport::TestCase
    include Zero
    def test_has_add
      change.add("Section" , "name")
      assert_equal "name",  change.added("Section").first.last
      assert_equal :Section,  change.added("Section").first.first
    end
    def test_has_edit
      change.edit("Section" , "name")
      assert_equal "name",  change.edited("Section").first.last
      assert_equal :Section,  change.edited("Section").first.first
    end
    def test_has_delete
      change.delete("Section" , "name")
      assert_equal "name",  change.deleted("Section").first.last
      assert_equal :Section,  change.deleted("Section").first.first
    end

  end
  class ChangeSetWriteTest < ActiveSupport::TestCase
    include Cleanup
    include Zero

    def test_page_edit
      studios = Page.first
      studios.edit_save("email")
      assert_equal "studios" , change.edited("Page").first.last
    end
    def test_section_edit
      studios = Section.first
      studios.edit_save("email")
      assert_equal "studios:Studios" , change.edited("Section").first.last
    end
    def test_card_edit
      studios = Card.first
      studios.edit_save("email")
      assert_equal "studios:Standard" , change.edited("Card").first.last
    end

    def test_page_new
      studios = Page.new_page("new" , :page)
      studios.add_save("email")
      assert_equal "new" , change.added("Page").first.last
      assert_nil change.edited("Page").first
    end
    def test_section_new
      studios = Page.first.new_section()
      studios.add_save("email")
      assert_equal "studios:" , change.added("Section").first.last
      assert_nil change.edited("Section").first
    end
    def test_card_new
      studios = Card.first.section.new_card()
      studios.add_save("email")
      assert_equal "studios:NEW" , change.added("Card").first.last
      assert_nil change.edited("Card").first
    end

    def test_page_delete
      studios = Page.first
      studios.delete_save!
      assert_equal "studios" , change.deleted("Page").first.last
      assert_nil change.edited("Page").first
    end
    def test_section_delete
      studios = Section.first
      studios.delete_save!()
      assert_equal "studios:Studios" , change.deleted("Section").first.last
      assert_nil change.edited("Section").first
    end
    def test_card_delete
      studios = Card.first
      studios.delete_save!()
      assert_equal "studios:Standard" , change.deleted("Card").first.last
      assert_nil change.edited("Card").first
    end

  end
end
