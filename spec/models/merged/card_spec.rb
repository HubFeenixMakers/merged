require 'rails_helper'

module Merged
  RSpec.describe Card, type: :model do
    let(:first) {Card.all.values.first}

    it "has Card.all" do
      expect(Card.all.class).to be Hash
    end
    it "has cards" do
      expect(first.class).to be Card
    end
    it "has index" do
      expect(first.index).to eq 0
    end
  end
end
