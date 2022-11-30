require 'rails_helper'

module Merged
  RSpec.describe Page, type: :model do
    let(:index) {Page.find('index')}

    it "has Pages.all" do
      expect(Page.all.class).to be Hash
    end
    it "has index page" do
      expect(index.class).to be Page
    end
    it "has sections" do
      expect(index.sections.length).to be 1
    end
    it "has section array" do
      expect(index.sections.class).to be Array
    end
  end
end
