require 'rails_helper'

module Merged
  RSpec.describe Image, type: :model do
    let(:first) {Image.first}

    it "has Image.all" do
      expect(Image.all.length).to be 17
    end
    it "has image" do
      expect(first.class).to be Image
    end
    it "has name" do
      expect(first.name).to eq "Common spaces"
    end
    it "has height and width" do
      expect(first.height).to eq 300
      expect(first.width).to eq 560
    end
    it "has height and width" do
      expect(first.aspect_ratio).to eq [13,7]
    end

  end
end
