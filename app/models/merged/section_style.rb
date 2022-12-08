module Merged
  class SectionStyle < CardStyle

    @@sections = {}

    def has_cards?
      @content["cards"] == true
    end

    def section_preview
      "merged/section_preview/" + template
    end

    def self.sections
      @@sections
    end

    def self.load(yaml)
      yaml.each do |content|
        section = SectionStyle.new(content)
        @@sections[section.template] = section
      end
    end

  end
end
