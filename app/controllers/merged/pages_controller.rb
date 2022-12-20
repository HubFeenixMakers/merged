module Merged
  class PagesController < MergedController

    before_action :set_page, only: %i[ update destroy show ]

    def index
      @pages = Page.all
    end

    def show

    end

    def update
      @page.add_redirect
      @page.name = params[:name]
      @page.save
      redirect_to page_url(@page) , notice: "Page renamed"
    end

    def create
      name = params[:name]
      message = Page.check_name(name)
      message = "Must enter name" if name.blank?
      if( message.nil?)
        @page = Page.new_page(name)
        @page.save
        redirect_to new_page_section_url(@page.id) , notice: "Page was successfully created."
      else
        @pages = Page.all.values
        flash.now.alert = message
        render :index
      end
    end

    def destroy
      @page.destroy()
      redirect_to pages_url, notice: "Page #{@page.name} was removed."
    end

    private
    def set_page
      @page = Page.find(params[:id])
    end

  end
end
