module Merged
  class CardsController < MergedController
    before_action :set_card , except: :index

    def index
      @section = Section.find(params[:section_id])
    end

    private
    def set_page
      @page = Page.find(params[:page_id])
      section_id = params[:id] || params[:section_id]
      @section = @page.find_section( section_id )
    end

  end
end
