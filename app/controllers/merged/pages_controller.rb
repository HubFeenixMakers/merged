module Merged
  class PagesController < MergedController

    before_action :set_page, only: %i[ update destroy show ]

    def index
      @pages = Page.all
    end

    def show

    end

    def update
      if( !params[:name].blank?  && (params[:name] != @page.name))
        @page.add_redirect
        @page.name = params[:name]
        @page.edit_save(current_member.email)
        message = "Page renamed"
      end
      redirect_to page_url(@page) , notice: message
    end

    def create
      name = params[:name]
      if( name.blank? )
        @pages = Page.all
        flash.now.alert = "Must enter name"
        render :index
      else
        @page = Page.new_page(name)
        @page.add_save(current_member.email)
        redirect_to new_page_section_url(@page.id) , notice: "Page was successfully created."
      end
    end

    def destroy
      @page.delete()
      redirect_to pages_url, notice: "Page #{@page.name} was removed."
    end

    private
    def set_page
      @page = Page.find(params[:id])
    end

  end
end
