require 'rails_helper'

module Merged
  RSpec.describe Option, type: :model do
    let(:first) {Option.first}

    it "has Option.first" do
      expect(Option.first.class).to be Option
    end
    it "there are options" do
      expect(Option.all.length).to be 16
    end
    it "has option objects" do
      expect(first.class).to be Option
    end
    it "has values" do
      expect(first.values.class).to be Array
    end
  end
end
