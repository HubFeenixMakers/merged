require 'rails_helper'

module Merged
  RSpec.describe Option, type: :model do
    let(:first) {Option.options.values.first}

    it "has Option.options" do
      expect(Option.options.class).to be Hash
    end
    it "there are options" do
      expect(Option.options.length).to be 16
    end
    it "has option objects" do
      expect(first.class).to be Option
    end
  end
end
