module Merged
  class StylesController < MergedController

    def index
      @sections = SectionStyle.sections
      @cards = CardStyle.cards
    end

  end
end
