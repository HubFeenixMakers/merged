require 'rails_helper'

module Merged
  RSpec.describe CardStyle, type: :model do
    let(:first_card) {Style.cards.first}

    it "has Style.cards" do
      expect(CardStyle.cards.class).to be Hash
      expect(CardStyle.cards.length).to be 4
    end

  end
end
