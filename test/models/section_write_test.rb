require "test_helper"

module Merged
  class SectionTest < ActiveSupport::TestCase
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
      last.delete
      assert_raises(ActiveHash::RecordNotFound){Section.find(last_id) }
    end

    def test_destroys
      last_id = last.id
      last.destroy
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Section.find(last_id) }
    end
    def test_destroys_cards
      card_id = last.cards.first.id
      last.destroy
      Section.reload
      assert_raises(ActiveHash::RecordNotFound){Card.find(card_id) }
    end

  end
end
