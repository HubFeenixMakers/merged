module Merged
  class ViewController < ::ApplicationController

    def view
      @page = Page.find(params[:id])
    end

  end
end
