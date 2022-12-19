module Merged
  class SectionsController < MergedController
    before_action :set_section , except: [:index ,:new]
    #, only: %i[ show edit update destroy set_image select_image]

    def index
      @page = Page.find(params[:page_id])
    end

    def select_template
      @sections = SectionStyle.all
    end

    def select_card_template
      @cards = CardStyle.all
    end

    def new
      page = Page.find(params[:page_id])
      template = params[:template]
      new_section = page.new_section(template)
      new_section.save
      if(template.blank?) # new
        redirect_to section_select_template_url(new_section.id), notice: "New section created"
      else # copy
        redirect_to section_url(new_section.id), notice: "Section copied"
      end
    end

    def destroy
      @section.destroy()
      redirect_to page_sections_url(@section.page.id) , notice: "Section #{@section.header} removed"
    end

    def set_image
      @section.image_id = params[:image_id]
      @section.save
      redirect_to section_url(@section.id) , notice: "Image selected: #{@section.image.name}"
    end

    def set_template
      template = params[:template]
      raise "no template given" if template.blank?
      @section.set_template( template )
      @section.save
      redirect_to section_url(@section.id)
    end

    def set_card_template
      card_template = params[:card_template]
      raise "no card template given" if card_template.blank?
      @section.card_template = card_template
      @section.save
      redirect_to section_url(@section.id)
    end

    def move
      if( params[:dir] == "up")
        @section.move_up
      else
        @section.move_down
      end
      @section.save
      redirect_to page_sections_url(@section.page.id)
    end

    def update
      @section.allowed_fields.each do |key|
        if( params.has_key?(key) )
          @section.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      options = params[:option]
      @section.option_definitions.each do |option|
        @section.set_option(option.name,  options[option.name])
      end if options
      @section.save
      redirect_to :section , notice: "Update ok"
    end

    private
    def set_section
      @section = Section.find( params[:id] || params[:section_id] )
    end

  end
end
