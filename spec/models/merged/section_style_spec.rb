require 'rails_helper'

module Merged
  RSpec.describe SectionStyle, type: :model do
    let(:first_section) {SectionStyle.all.first}

    it "finds stye" do
      spacer = SectionStyle.find_by_template("section_spacer")
      expect(spacer).not_to be nil
    end

    it "has Style.sections" do
      expect(SectionStyle.all.length).to be 7
    end
    it "Finds section by template" do
      spacer = SectionStyle.find_by_template("section_spacer")
      expect(spacer).not_to eq nil
    end
    it "Spacer has no fields" do
      spacer = SectionStyle.find_by_template("section_spacer")
      expect(spacer.fields).to be nil
    end
    it "Spacer has no fields" do
      spacer = SectionStyle.find_by_template("section_spacer")
      expect(spacer.fields).to be nil
    end
  end
end
