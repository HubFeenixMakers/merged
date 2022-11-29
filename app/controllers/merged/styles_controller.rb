module Merged
  class StylesController < MergedController

    def index
      @sections , @cards = Style.all
    end

  end
end
