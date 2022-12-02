require 'rails_helper'

module Merged
  RSpec.describe Style, type: :model do
    let(:first_section) {Style.sections.first}
    let(:first_card) {Style.cards.first}

    it "has Style.sections" do
      expect(Style.sections.class).to be Hash
      expect(Style.sections.length).to be 6
    end
    it "has Style.cards" do
      expect(Style.cards.class).to be Hash
      expect(Style.cards.length).to be 1
    end
    it "Finds section by template" do
      spacer = Style.sections["section_spacer"]
      expect(spacer).not_to eq nil
    end
    it "Spacer has no fields" do
      spacer = Style.sections["section_spacer"]
      expect(spacer.fields).to be nil
    end
    it "2 col has fields" do
      spacer = Style.sections["section_2_col"]
      expect(spacer.fields.class).to be Array
      expect(spacer.fields.length).to be 2
    end

  end
end
