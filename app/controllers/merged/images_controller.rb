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

    def show
      @image = Image.find(params[:id])
    end

    def create
      new_image = Image.create_new(params['filename'] , params['image_file'])
      redirect = :images
      if(params[:redirect])
        redirect = params[:redirect].gsub("NEW" ,new_image.name)
        puts "image redirect #{redirect}"
      end
      redirect_to redirect
    end

    private
    def build_link_for(image)
      if(params[:section_id])
        return view_context.section_set_image_url(params[:section_id] , image_id: image.id)
      end
      view_context.image_url(image.id)
    end
  end

end
