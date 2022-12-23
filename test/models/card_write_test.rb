require "git"
require "test_helper"

module Merged
  class CardWriteTest < ActiveSupport::TestCase
    include CardHelper
    include Cleanup

    def test_deletes
      id = first.id
      first.delete
      assert_raises(ActiveHash::RecordNotFound) {Card.find(id) }
    end

    def test_destroys
      id = first.id
      first.delete
      Card.reload
      assert_raises(ActiveHash::RecordNotFound) {Card.find(id) }
    end

  end
end
