module Merged
  class StylesController < MergedController

    def index
      @sections = Style.sections
      @cards = Style.cards
    end

  end
end
