require 'rails_helper'

RSpec.feature "Sections", type: :feature do
  describe "index page" do
    it "returns http success" do
      visit "/merged/pages"
      click_on ("index")
      expect(page).to have_text("index")
      expect(page).to have_text("Section 1")
    end
  end
  describe "show page" do
    it "returns http success" do
      visit "/merged/pages"
      click_on ("index")
      within("#section_31") do
        find_link("Edit").click
      end
    end
  end
end
