module Merged
  class ViewController < ::ApplicationController
    include MergedHelper

    def view
      @page = Page.find(params[:id])
    end

  end
end
