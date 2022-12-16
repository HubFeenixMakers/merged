require 'rails_helper'

module Merged
  RSpec.describe PageStyle, type: :model do
    let(:first) {PageStyle.all.first}

    it "finds stye" do
      spacer = PageStyle.find_by_type("page")
      expect(spacer).not_to be nil
    end

    it "has Style.sections" do
      expect(PageStyle.all.length).to be 1
    end
    it "Spacer has no fields" do
      expect(first.description).not_to be nil
    end
  end
end
