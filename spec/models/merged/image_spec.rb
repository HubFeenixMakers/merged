require 'rails_helper'

module Merged
  RSpec.describe Image, type: :model do
    let(:first) {Image.all.values.first}

    it "has Pages.all" do
      expect(Image.all.class).to be Hash
    end
    it "has image" do
      expect(first.class).to be Image
    end
    it "image has name" do
      expect(first.name).to eq "3dprinter_wide"
    end
  end
end
