require 'rails_helper'

module Merged
  RSpec.describe Page, type: :model do
    let(:index) {Page.find_by_name('index')}

    it "has Pages.all" do
      expect(Page.all.length).to be 6
    end
    it "has index page" do
      expect(index.class).to be Page
    end
    it "has sections" do
      expect(index.sections.length).to be 10
    end
    it "has section array" do
      expect(index.sections.first.class).to be Section
    end
    it "has section indexes" do
      index.sections.each_with_index do |section, index|
        expect(section.index).to be index + 1
      end
    end
  end
end
