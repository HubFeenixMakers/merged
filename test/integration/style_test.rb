require "test_helper"

class StylesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_returns_success
    visit "/merged/styles/index"
    assert_title page, "Dummy"
    assert_text page, "Styles"
  end
end
