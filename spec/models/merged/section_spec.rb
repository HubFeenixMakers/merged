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
    it "has sections" do
      expect(first.cards.length).to be 2
    end
  end
end
