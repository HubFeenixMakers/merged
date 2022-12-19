module Merged

  class ImagesController < MergedController

    def index
      @images = Image.all
      @image_data = @images.collect{|i|
        data = i.attributes.dup
        data[:url] = view_context.asset_path(i.asset_name)
        data[:link] = build_link_for(i)
        data[:created_at] = i.created_at.to_date
        data[:created] = i.created_at.to_i
        data[:aspect_ratio] = i.aspect_ratio.join("/")
        data[:ratio] = i.aspect_ratio
        data
      }
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      redirect_to :images , nootice: "Image #{@image.name} deleted"
    end

    def show
      @image = Image.find(params[:id])
      @sections = Section.where(image_id: params[:id].to_i)
      @cards = Card.where(image_id: params[:id].to_i)
      @used = ((@cards.length > 0) || (@sections.length > 0))
    end

    def create
      image = Image.create_new!(params['filename'] ,params['tags'], params['image_file'])
      where_to  = determine_redirect(image)
      redirect_to where_to , notice: "New image created: #{image.name}"
    end

    private

    def determine_redirect(image)
      if(params[:section_id])
        view_context.section_set_image_url(params[:section_id],image_id: image.id )
      elsif(params[:card_id])
        view_context.card_set_image_url(params[:card_id],image_id: image.id )
      else
         :images
      end
    end

    def build_link_for(image)
      if(params[:section_id])
        return view_context.section_set_image_url(params[:section_id] , image_id: image.id)
      end
      if(params[:card_id])
        return view_context.card_set_image_url(params[:card_id] , image_id: image.id)
      end
      view_context.image_url(image.id)
    end
  end

end
