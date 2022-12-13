require 'rails_helper'

RSpec.feature "Pages", type: :feature do
  describe "GET /pages" do
    it "returns http success" do
      visit "/merged/pages"
      expect(page).to have_title("Dummy")
      expect(page).to have_text("Pages")
    end
  end
  describe "index page" do
    it "returns http success" do
      visit "/merged/pages"
      click_on ("index")
    end
  end
end
