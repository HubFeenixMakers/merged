require 'rails_helper'

module Merged
  RSpec.describe Section, type: :model do
    let(:first) {Section.last}

    it "has Sections.all" do
      expect(Section.all.length).to be 40
    end
    it "has index page" do
      expect(first.class).to be Section
    end
    it "has index" do
      expect(first.index).to eq 10
    end
    it "has cards" do
      expect(first.cards.length).to eq 5
    end
    it "has cards array" do
      expect(first.cards.class).to be ActiveHash::Relation
    end
  end
end
