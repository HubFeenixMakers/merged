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
      expect(last.option_definitions.second.class).to be OptionDefinition
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

    it "creates new spacer section" do
      s = Section.new_section("section_spacer" , 1  , 1)
      expect(s.template).to eq "section_spacer"
    end

    it "creates card with right index" do
      s = Section.find_by_template("section_cards")
      length = s.cards.length
      c = s.new_card
      expect(c.index).to eq length + 1
    end

    it "deletes " do
      last_id = last.id
      last.delete
      expect{Section.find(last_id) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "destroys " do
      last_id = last.id
      last.destroy
      Section.reload
      expect{Section.find(last_id) }.to raise_error(ActiveHash::RecordNotFound)
    end
    it "destroys cards" do
      card_id = last.cards.first.id
      last.destroy
      Section.reload
      expect{Card.find(card_id) }.to raise_error(ActiveHash::RecordNotFound)
    end

  end
end
