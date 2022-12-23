require "test_helper"

class ViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_returns_ok_all_pages
    Merged::Page.all.each do |page|
      visit "/" + page.name
      assert_equal "/#{page.name}" , current_path
    end
  end
end
