require "test_helper"

class ChangesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_index
    #      visit "/merged/changes/index"
    #      assert_equal page, have_title("Deletions")
    #      assert_equal page, have_text("Additions")
  end
end
