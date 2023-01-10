require "test_helper"

class ImagesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  def test_index
    visit "/merged/images"
    assert_title page, "Merged"
    assert_text page, "Pages"
  end

  def test_has_picures
    Capybara.current_driver = :selenium_headless # js: true
    expexted_num = Merged::Image.count
    visit "/merged/images"
    found= find_all(".image_box").count
    assert_equal found, expexted_num
  end
end
