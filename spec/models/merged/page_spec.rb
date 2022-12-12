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
        expect(section.index).to be index + 1 # because we have human index
      end
    end

    it "deletes " do
      id = index.id
      index.delete
      expect{Page.find(id) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "destroys " do
      id = index.id
      index.destroy
      Section.reload
      expect{Page.find(id) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "destroys sections" do
      id = index.sections.first.id
      index.destroy
      Section.reload
      expect{Page.find(id) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "creates simple section" do
      s = index.new_section("section_spacer")
      expect(s).not_to be nil
      expect(s.template).to eq "section_spacer"
    end
    it "creates page" do
      name = "randomname"
      page = Page.new_page( name)
      expect(page.name).to eq name
    end
  end
end
