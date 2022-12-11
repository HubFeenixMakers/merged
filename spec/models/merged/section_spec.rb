require 'rails_helper'

module Merged
  RSpec.describe Section, type: :model do
    let(:first) {Section.find_by_id(1)}
    let(:second) {Section.find_by_id(2)}
    let(:last) {Section.last}

    it "has Sections.all" do
      expect(Section.all.length).to be 40
    end
    it "has index page" do
      expect(last.class).to be Section
    end
    it "has index" do
      expect(last.index).to eq 10
    end
    it "has cards" do
      expect(last.cards.length).to eq 5
    end
    it "has cards array" do
      expect(last.cards.class).to be ActiveHash::Relation
    end
    it "has options" do
      expect(second.options.class).to be Hash
      expect(second.options.length).to be 6
    end
    it "has option_definitions" do
      expect(last.option_definitions.class).to be Array
      expect(last.option_definitions.length).to be 4
      expect(last.option_definitions.second.class).to be Option
      expect(last.option_definitions.second.name).to eq "handler"
    end
    it "last has previous" do
      expect(last.previous_section.index).to be 9
    end
    it "first has no previous" do
      expect(first.index).to be 1
      expect(first.previous_section).to be nil
    end
    it "first has next" do
      expect(first.next_section.index).to be 2
    end
    it "last has no next" do
      expect(last.next_section).to be nil
    end
  end
end
