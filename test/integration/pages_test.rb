require "test_helper"

class PageTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_returns_success
    visit "/merged/pages"
    assert_title page, "Merged"
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
  def test_new_handles_noinput
    visit "/merged/pages"
    within(".new_page") do
      click_on ("New Page")
    end
    assert_equal "/merged/pages" , current_path
  end
  def test_new_page_works_with_name
    visit "/merged/pages"
    within(".new_page") do
      fill_in 'Name', with: 'New Page'
      click_on ("New Page")
    end
    assert_equal "/merged/sections/41/select_template" , current_path
  end

  def test_new_blog_works_with_name
    visit "/merged/pages"
    within(".new_page") do
      fill_in 'Name', with: 'New Page'
      click_on ("New Blog")
    end
    assert_equal "/merged/sections/41" , current_path
  end

  def test_delete_works
    id = Merged::Page.first.id
    visit merged.page_sections_path(id)
    within(".delete_page") do
      click_on ("Delete Page")
    end
    assert_equal "/merged/pages" , current_path
    assert_raise(ActiveHash::RecordNotFound) {visit merged.page_path(id)}
  end

end
