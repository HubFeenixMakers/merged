require "test_helper"

class CardsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def go_edit
    visit "/merged/sections/11"
    find_link("View and Edit Cards").click
  end
  def test_edit_is
    go_edit
    assert_equal page.current_path , "/merged/sections/11/cards"
  end

  def test_update
    go_edit
    within("#card_6") do
      find_button("Update" , match: :first).click
    end
  end

  def _test_update
    go_edit
    within(".content_update") do
      find_button("Update").click
    end
  end

  class CardsWriteTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers # Rails >= 5
    include Merged::Cleanup

    def test_remove_image
      visit "merged/sections/11/cards"
      find_button("Remove image", match: :first).click
      assert_equal 200 , page.status_code
    end

    def test_remove_image_force
      visit "merged/cards/6/set_image?image=''"
      assert_text page , "No image"
    end
  end
end
