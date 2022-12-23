require "git"
require "test_helper"

module Merged
  class CardTest < ActiveSupport::TestCase
    include CardHelper

    def test_has_all
      assert_equal 20 , Card.all.length
    end
    def test_has_cards
      assert_equal first.class ,  Card
    end
    def test_has_index
      assert_equal first.index ,  1
    end

    def test_first_has_no_previous
      assert_equal first.index ,  1
      assert_nil first.previous_card
    end
    def test_first_has_next
      assert_equal first.next_card.index ,  2
    end

    def test_create_new
      card = Card.new_card("card_normal_square" , 1 , 1)
      assert_equal card.index ,  1
    end


  end
end
