module Merged
  class CardsController < MergedController
    before_action :set_card , except: [:index , :new]

    def index
      @section = Section.find(params[:section_id])
    end

    def set_image
      @card.image_id = params[:image_id].to_i
      @card.edit_save(current_member.email)
      message = @card.image ? "#{@card.image.name} selected" : "Image removed"
      redirect_to section_cards_url(@card.section.id) , notice: message
    end

    def move
      if( params[:dir] == "up")
        @card.move_up
      else
        @card.move_down
      end
      @card.edit_save(current_member)
      redirect_to section_cards_url(@card.section.id),notice: "#{@card.header} moved"
    end

    def new
      @section = Section.find(params[:section_id])
      new_card =  @section.new_card
      new_card.add_save(current_member.email)
      redirect_to section_cards_url(@section.id) , notice: "Card created"
    end

    def destroy
      @card.delete_and_reset_index(current_member.email)
      redirect_to section_cards_url(@card.section.id) , notice: "#{@card.header} removed"
    end

    def update
      @card.allowed_fields.each do |key|
        if( params.has_key?(key) )
          @card.update(key, params[key])
        end
      end
      options = params[:option]
      @card.option_definitions.each do |option|
        @card.set_option(option.name,  options[option.name])
      end if options
      @card.edit_save(current_member.email)
      redirect_to section_cards_url(@card.section.id) , notice: "Updated #{@card.header}"
    end

    private
    def set_card
      card_id = params[:id] || params[:card_id]
      @card = Card.find( card_id )
    end

  end
end
