require "test_helper"

module Merged
  class SectionWriteTest < ActiveSupport::TestCase
    include SectionHelper
    include Cleanup

    def test_creates_new_spacer_section
      s = Section.new_section("section_spacer" , 1  , 1)
      assert_equal s.template ,  "section_spacer"
    end

    def test_creates_card_with_right_index
      s = Section.find_by_template("section_cards")
      length = s.cards.length
      c = s.new_card
      assert_equal c.index ,  length + 1
    end

    def test_deletes
      last_id = last.id
      last.delete("you")
      assert_raises(ActiveHash::RecordNotFound){Section.find(last_id) }
    end

    def test_delete_index_section
      eleven = Section.find 11
      page = eleven.page
      eleven.delete("you")
      assert_equal eleven.index + 1 , page.sections.second.index
    end

    def test_delete_index_page
      eleven = Section.find 11
      page = eleven.page
      index = eleven.index
      eleven.delete_and_reset_index("you")
      assert_equal index , page.sections.second.index
    end

    def test_destroys
      last_id = last.id
      last.delete("you")
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Section.find(last_id) }
    end
    def test_destroys_cards
      card_id = last.cards.first.id
      last.delete("you")
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Card.find(card_id) }
    end

  end
end
