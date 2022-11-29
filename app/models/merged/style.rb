module Merged
  class Style
    include ActiveModel::API

    cattr_accessor :sections , :cards
    @@sections = []
    @@cards = []

    attr_reader :content

    def initialize content
      @content = content
    end
    def template
      @content["template"]
    end
    def header
      @content["header"]
    end
    def text
      @content["text"]
    end
    def cards
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
        all["sections"].each { |content| @@sections << Style.new(content) }
        all["cards"].each { |content| @@cards << Style.new(content) }
      end
      [@@sections , @@cards]
    end

  end
end
