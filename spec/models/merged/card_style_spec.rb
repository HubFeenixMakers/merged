require 'rails_helper'

module Merged
  RSpec.describe CardStyle, type: :model do
    let(:first_card) {CardStyle.all.first}

    it "has .all" do
      expect(CardStyle.all.length).to be 5
    end

    it "has fields" do
      expect(first_card.fields.class).to be Array
      expect(first_card.fields.length).to be 2
      expect(first_card.fields.first).to eq "header"
    end
  end
end
