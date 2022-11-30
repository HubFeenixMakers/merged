require 'rails_helper'

module Merged
  RSpec.describe Section, type: :model do
    let(:first) {Section.all.values.first}

    it "has Sections.all" do
      expect(Section.all.class).to be Hash
    end
    it "has index page" do
      expect(first.class).to be Section
    end
    it "has index" do
      expect(first.index).to eq 0
    end
    it "has cards" do
      expect(first.cards.length).to eq 2
    end
    it "has cards array" do
      expect(first.cards.class).to be Array
    end
  end
end
