module Merged
  class FormController < MergedController

    def sendit
      @section = Section.find( params[:section_id] )
      @errors = { }
      return if bot_alert
      check_maths
      verify_data
      if( @errors.length > 0)
        render :form
      else
        dispatch_form_data( )
        redirect_to main_app.root_url , notice: @section.option("ok_message")
      end
    end

    private

    def dispatch_form_data
      puts "Dispatch data"
      data = {}
      @section.cards.each do |card|
        data[card.header] = params[card.header]
      end
      if(@section.has_option?("handler") )
        puts "Sending data"
        @section.option("handler").constantize.new.handle_form(@section, data)
      end
    end

    def verify_data
      @section.cards.each do |card|
        check_option( card , params[card.header])
      end
    end
    def check_option(card , value)
      return unless value.blank?
      puts "Checking #{card.header} #{value}"
      compulsory = card.option("compulsory") == "yes"
      return unless compulsory
      # check different types
      @errors[card.header] = "May not be blank"
    end

    def check_maths
      key = params[:bot_fudder].to_i / 2
      if( (2*key + 1).to_s != params[:challenge])
        @errors[:challenge] = "Check the maths #{key.to_i} #{params[:challenge]}"
      end
    end

    def bot_alert
      if @section.nil?
        head :ok
        return true
      end
      key = params[:bot_fudder]
      if key.to_i.to_s != key
        head :ok
        return true
      end
      return false
    end
  end
end
