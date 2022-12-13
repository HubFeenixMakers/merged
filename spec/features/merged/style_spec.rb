require 'rails_helper'

RSpec.feature "Styles", type: :feature do
  describe "GET /styles" do
    it "returns http success" do
      visit "/merged/styles/index"
      expect(page).to have_title("Dummy")
      expect(page).to have_text("Styles")
    end
  end
end
