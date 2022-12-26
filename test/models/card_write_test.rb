require "git"
require "test_helper"

module Merged
  class CardWriteTest < ActiveSupport::TestCase
    include CardHelper
    include Cleanup

    def test_deletes
      id = first.id
      first.delete_save!
      assert_raises(ActiveHash::RecordNotFound) {Card.find(id) }
    end

    def test_adds
      card = Card.first.section.new_card
      card.add_save!
      assert_equal "NEW" , card.header
    end


  end
end
