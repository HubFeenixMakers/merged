module Merged
  class StylesController < MergedController

    def index
      @page_styles = PageStyle.all
      @section_styles = SectionStyle.all
      @cards_styles = CardStyle.all
    end

  end
end
