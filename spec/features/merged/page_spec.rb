require 'rails_helper'

RSpec.feature "Pages", type: :feature do
  describe "GET /pages" do
    it "returns http success" do
      visit "/merged/pages"
      expect(page).to have_title("Dummy")
      expect(page).to have_text("Pages")
    end

    it "has an index page" do
      visit "/merged/pages"
      click_on ("index")
    end

    it "edit page works " do
      visit "/merged/pages"
      within("#index") do
        click_on ("Edit")
      end
    end
  end
end
