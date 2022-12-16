require 'rails_helper'
require "git"

module Merged
  RSpec.describe Card, type: :model do
    let(:first) {Card.first}

    it "has Card.all" do
      expect(Card.all.length).to be 20
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

    it "create a new" do
      card = Card.new_card("card_normal_square" , 1 , 1)
      expect(card.index).to eq 1
    end

    it "deletes " do
      id = first.id
      first.delete
      expect{Card.find(id) }.to raise_error(ActiveHash::RecordNotFound)
    end

    it "destroys " do
      id = first.id
      first.delete
      Card.reload
      expect{Card.find(id) }.to raise_error(ActiveHash::RecordNotFound)
    end

  end
end
