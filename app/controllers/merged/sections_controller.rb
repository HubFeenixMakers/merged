module Merged
  class SectionsController < MergedController
    before_action :set_section , except: [:index ,:new]
    #, only: %i[ show edit update destroy set_image select_image]

    def index
      @page = Page.find(params[:page_id])
    end

    def select_image
      @images = Image.all
    end
    def select_template
      @sections = Style.sections
    end
    def select_card_template
      @cards = Style.cards
    end

    def new
      page = Page.find(params[:page_id])
      new_section = page.new_section
      redirect_to section_select_template_url(new_section.id)
    end

    def remove
      page = @section.page
      page.remove_section( @section )
      page.save
      redirect_to page_sections_url(page.name)
    end

    def set_image
      @section.content["image"] = params[:image]
      @section.save
      redirect_to section_url(@section.id)
    end

    def set_template
      template = params[:template]
      raise "no template given" if template.blank?
      @section.content["template"] = template
      @section.save
      redirect_to section_url(@section.id)
    end

    def set_card_template
      card_template = params[:card_template]
      raise "no card template given" if card_template.blank?
      @section.content["card_template"] = card_template
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
      redirect_to page_sections_url(@section.page.name)
    end

    def update
      @section.allowed_fields.each do |key|
        puts "Update #{key}"
        if( params.has_key?(key) )
          @section.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      @section.save
      redirect_to :section
    end

    private
    def set_section
      @section = Section.find( params[:id] || params[:section_id] )
    end

  end
end
