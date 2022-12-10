require 'rails_helper'

module Merged
  RSpec.describe SectionStyle, type: :model do
    let(:first_section) {SectionStyle.sections.first}

    it "has Style.sections" do
      expect(SectionStyle.sections.class).to be Hash
      expect(SectionStyle.sections.length).to be 7
    end
    it "Finds section by template" do
      spacer = SectionStyle.sections["section_spacer"]
      expect(spacer).not_to eq nil
    end
    it "Spacer has no fields" do
      spacer = SectionStyle.sections["section_spacer"]
      expect(spacer.fields).to be nil
    end

  end
end
