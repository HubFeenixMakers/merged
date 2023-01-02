require "test_helper"

class SectionsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def go_index
    visit "/merged/pages"
    click_on ("index")
  end
  def go_edit
    go_index
    within("#section_31") do
      find_link("Edit").click
    end
  end
  def test_edit_is
    go_index
    within("#section_31") do
      assert has_link?("Edit")
    end
  end

  def test_edit_ok
    go_index
    within("#section_31") do
      find_link("Edit").click
    end
  end

  def test_update
    go_edit
    within(".content_update") do
      find_button("Update").click
    end
  end
  class SectionsWriteTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers # Rails >= 5
    include Merged::Cleanup

    def test_remove_image
      visit "merged/sections/31"
      within(".image") do
        click_button("Remove image")
      end
      assert_equal 200 , page.status_code
    end

    def test_remove_image_force
      visit "merged/sections/31/set_image?image=''"
      assert_text page , "No Image"
    end

  end
end
