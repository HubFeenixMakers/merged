require 'rails_helper'

RSpec.feature "View", type: :feature do
  describe "Check rendering" do

    it "returns http successfor all pages" do
      Merged::Page.all.each do |page|
        visit "/" + page.name
      end
    end
  end
end
