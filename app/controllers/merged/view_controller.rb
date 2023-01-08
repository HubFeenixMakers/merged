module Merged
  class ViewController < ::ApplicationController

    def page
      @page = Page.find_by_name(params[:id])
    end

  end
end
