require 'rails_helper'

module Merged
  RSpec.describe OptionDefinition, type: :model do
    let(:first) {OptionDefinition.first}

    it "has OptionDefinition.first" do
      expect(OptionDefinition.first.class).to be OptionDefinition
    end
    it "there are options" do
      expect(OptionDefinition.all.length).to be 17
    end
    it "has option objects" do
      expect(first.class).to be OptionDefinition
    end
    it "has values" do
      expect(first.values.class).to be Array
    end
  end
end
