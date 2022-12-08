require 'rails_helper'

RSpec.feature "Images", type: :feature do
  describe "GET /images" do
    it "returns http success" do
      visit "/merged/images"
      expect(page).to have_title("Merged")
      expect(page).to have_text("Pages")
    end
  end
end
