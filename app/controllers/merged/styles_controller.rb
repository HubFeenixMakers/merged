module Merged
  class StylesController < MergedController

    def index
      @styles = Style.all
    end
    
  end
end
