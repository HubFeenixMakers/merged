module Merged
  class Style
    include ActiveModel::API

    @@options ={}
    @@sections = {}
    @@cards = {}

    attr_reader :content

    def initialize content
      @content = content
    end

    [:template , :text , :header, :fields ].each do |meth|
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

    def options
      option_defs = []
      @content["options"].each do |name|
        option = Style.options[name]
        raise "no option for #{name}:name.class" if option.blank?
        option_defs << option
      end
      option_defs
    end

    def self.cards
      self.load
      @@cards
    end

    def self.options
      self.load
      @@options
    end

    def self.sections
      self.load
      @@sections
    end

    def self.load
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
        all["options"].each do |content|
          option = Option.new(content)
          @@options[option.name] = option
        end
      end
    end

  end
end
