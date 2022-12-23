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

class PagesWrite < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  include Merged::Cleanup
  def test_edit_page_works
    visit "/merged/pages/2"
    within(".options") do
      click_on ("Update")
    end
  end
  def test_new_works_without
    visit "/merged/pages"
    within(".new_page") do
      click_on ("New Page")
    end
  end
  def test_new_works_with_name
    visit "/merged/pages"
    within(".new_page") do
      fill_in 'Name', with: 'New Page'
      click_on ("New Page")
    end
  end

end
