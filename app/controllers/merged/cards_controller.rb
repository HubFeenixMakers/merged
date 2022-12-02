module Merged
  class CardsController < MergedController
    before_action :set_card , except: :index

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
      redirect_to section_cards_url(@card.section.id)
    end

    def remove
      section = @card.section
      section.remove_card( @card )
      section.save
      redirect_to section_cards_url(section.id)
    end

    def update
      @card.content.each do |key , value|
        next if key == "id"
        if(!params[key].nil?)
          @card.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      @card.save
      redirect_to section_cards_url(@card.section.id)
    end

    private
    def set_card
      card_id = params[:id] || params[:card_id]
      @card = Card.find_card( card_id )
    end

  end
end
