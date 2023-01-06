module Merged
  class PagesController < MergedController

    before_action :set_page, only: %i[ update destroy show ]

    def index
      @pages = Page.all
      if(! params[:type].blank?)
        @pages = @pages.where(type: params[:type])
      end
      @page_styles = PageStyle.all
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
      options = params[:option]
      if options
        @page.option_definitions.each do |option|
          @page.set_option(option.name,  options[option.name])
        end
        @page.edit_save(current_member.email)
        message = "Options saved"
      end
      redirect_to page_url(@page) , notice: message
    end

    def create
      name = params[:name]
      if( name.blank? )
        flash.alert = "Must enter name"
        redirect_to pages_url
      else
        @page = Page.new_page(name , params[:type])
        @page.add_save(current_member.email)
        template = PageStyle.find_by_type(@page.type).section_template
        if(template)
          section = @page.new_section(template)
          section.add_save(current_member.email)
          redirect_to section_url(section.id) , notice: "Page was successfully created."
        else
          redirect_to new_page_section_url(@page.id) , notice: "Page was successfully created. Choose first section"
        end
      end
    end

    def destroy
      @page.delete_save!(current_member.email)
      redirect_to pages_url, notice: "Page #{@page.name} was removed."
    end

    private
    def set_page
      @page = Page.find(params[:id])
    end

  end
end
