module Merged
  class StylesController < MergedController

    def index
      @section_styles = SectionStyle.all
      @cards_styles = CardStyle.all
    end

  end
end
