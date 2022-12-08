require 'rails_helper'

RSpec.feature "Changes", type: :feature do
  describe "GET /changes" do
    it "returns http success" do
      visit "/merged/changes"
      expect(page).to have_title("Merged")
      expect(page).to have_text("Pages")
    end
  end
end
