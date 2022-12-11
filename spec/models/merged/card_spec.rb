require 'rails_helper'
require "git"

module Merged
  RSpec.describe Card, type: :model do
    let(:first) {Card.first}

    it "has Card.all" do
      expect(Card.all.length).to be 46
    end
    it "has cards" do
      expect(first.class).to be Card
    end
    it "has index" do
      expect(first.index).to eq 1
    end

    it "first has no previous" do
      expect(first.index).to be 1
      expect(first.previous_card).to be nil
    end
    it "first has next" do
      expect(first.next_card.index).to be 2
    end

    it "deletes " do
      card = Card.find(20)
      expect(card).not_to be nil
      card.delete
      expect{Card.find(20) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "destroys " do
      Card.find(20).destroy
      Card.reload
      expect{Card.find(20) }.to raise_error(ActiveHash::RecordNotFound)
    end

  end
end
