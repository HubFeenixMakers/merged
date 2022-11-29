module Merged
  class SectionsController < MergedController
    before_action :set_page
    #, only: %i[ show edit update destroy set_image select_image]

    def select_image
      @images = Image.all
    end
    def select_template
      @sections = Style.sections
    end

    def set_image
      @section.content["image"] = params[:image]
      @page.save
      redirect_to page_section_url(@page.id,@section.id)
    end

    def set_template
      @section.content["template"] = params[:template]
      @page.save
      redirect_to page_section_url(@page.id,@section.id)
    end

    def update
      @section.content.each do |key , value|
        next if key == "id"
        if(!params[key].nil?)
          @section.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      @page.save
      redirect_to :page_section
    end

    private
    def set_page
      @page = Page.find(params[:page_id])
      section_id = params[:id] || params[:section_id]
      @section = @page.find_section( section_id )
    end

  end
end
