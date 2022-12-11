module Merged
  class CardsController < MergedController
    before_action :set_card , except: [:index , :new]

    def index
      @section = Section.find(params[:section_id])
    end

    def select_image
      @images = Image.all
    end

    def set_image
      @card.content["image"] = params[:image]
      @card.save
      redirect_to section_cards_url(@card.section.id)
    end

    def move
      if( params[:dir] == "up")
        @card.move_up
      else
        @card.move_down
      end
      @card.save
      redirect_to section_cards_url(@card.section.id),notice: "Card moved"
    end

    def new
      @section = Section.find(params[:section_id])
      new_card = @section.new_card
      redirect_to section_cards_url(@section.id) , notice: "Card created"
    end

    def destroy
      @card.destroy
      @card.section.save
      redirect_to section_cards_url(@card.section.id) , notice: "Card #{@card.index} removed"
    end

    def update
      @card.allowed_fields.each do |key|
        if( params.has_key?(key) )
          @card.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      options = params[:option]
      @card.option_definitions.each do |option|
        @card.set_option(option.name,  options[option.name])
      end if options
      @card.save
      redirect_to section_cards_url(@card.section.id) , notice: "Update ok"
    end

    private
    def set_card
      card_id = params[:id] || params[:card_id]
      @card = Card.find( card_id )
    end

  end
end
