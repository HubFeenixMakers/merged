require 'rails_helper'

RSpec.feature "Images", type: :feature do
  describe "GET /images" do
    it "returns http success" do
      visit "/merged/images"
      expect(page).to have_title("Dummy")
      expect(page).to have_text("Pages")
    end
    it "has picures" , js: true do
      expexted_num = Merged::Image.count
      visit "/merged/images"
      found= find_all(".image_box").count
      expect(found).to be expexted_num
    end
  end
end
