module Merged
  class CardStyle
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

    def card_preview
      "merged/card_preview/" + template
    end

    def options
      option_defs = []
      @content["options"].each do |name|
        option = Option.options[name]
        raise "no option for #{name}:#{name.class}" if option.blank?
        option_defs << option
      end if @content["options"]
      option_defs
    end

    def self.cards
      @@cards
    end

    def self.load( yaml )
      yaml.each do |content|
        card = CardStyle.new(content)
        @@cards[card.template] = card
      end
    end
  end
end
