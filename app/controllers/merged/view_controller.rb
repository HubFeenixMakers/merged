module Merged
  class ViewController < ::ApplicationController
    include MergedHelper

    def view
      @page = Page.find_by_name(params[:id])
    end

  end
end
