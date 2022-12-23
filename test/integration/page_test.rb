require "test_helper"

class PageTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_returns_success
    visit "/merged/pages"
    assert_title page, "Dummy"
    assert_text page, "Pages"
  end

  def test_has_an_index_page
    visit "merged/pages"
    click_on ("index")
  end

  def test_edit_page_works
    visit "/merged/pages"
    within("#index") do
      click_on ("Edit")
    end
  end
end
