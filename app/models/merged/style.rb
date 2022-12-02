module Merged
  class Style
    include ActiveModel::API

    cattr_accessor :sections , :cards
    @@sections = {}
    @@cards = {}

    attr_reader :content

    def initialize content
      @content = content
    end

    [:template , :text , :header, :fields].each do |meth|
      define_method(meth) do
        @content[meth.to_s]
      end
    end

    def cards?
      @content["cards"] == true
    end
    def section_preview
      "merged/section_preview/" + template
    end
    def card_preview
      "merged/card_preview/" + template
    end

    def self.cards
      self.all
      @@cards
    end

    def self.sections
      self.all
      @@sections
    end

    def self.all
      if @@sections.length == 0
        all = YAML.load_file(Engine.root.join("config/styles.yaml"))
        all["sections"].each do |content|
          section = Style.new(content)
          @@sections[section.template] = section
        end
        all["cards"].each do |content|
          card = Style.new(content)
          @@cards[card.template] = card
        end
      end
    end

  end
end
