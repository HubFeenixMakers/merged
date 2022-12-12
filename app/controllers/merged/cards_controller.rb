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
      @card.image = params[:image]
      @card.save
      redirect_to section_cards_url(@card.section.id) , notice: "Image selected: #{@card.image}"
    end

    def move
      if( params[:dir] == "up")
        @card.move_up
      else
        @card.move_down
      end
      @card.save
      redirect_to section_cards_url(@card.section.id),notice: "#{@card.header} moved"
    end

    def new
      @section = Section.find(params[:section_id])
      new_card =  @section.new_card
      new_card.save
      redirect_to section_cards_url(@section.id) , notice: "Card created"
    end

    def destroy
      @card.destroy
      redirect_to section_cards_url(@card.section.id) , notice: "#{@card.header} removed"
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
      redirect_to section_cards_url(@card.section.id) , notice: "Updated #{@card.header}"
    end

    private
    def set_card
      card_id = params[:id] || params[:card_id]
      @card = Card.find( card_id )
    end

  end
end
