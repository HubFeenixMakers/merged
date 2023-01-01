require "mini_magick"

module Merged
  class ImagesController < MergedController
    before_action :set_image, only: %i[ update destroy show scale crop copy ]

    def index
      @images = Image.all
      @image_data = @images.collect{|i|
        data = i.attributes.dup
        data[:url] = view_context.asset_path(i.asset_name)
        data[:link] = build_link_for(i)
        data[:updated_at] = i.updated_at.to_date if i.updated_at
        data[:created] = i.updated_at.to_i
        data[:aspect_ratio] = i.aspect_ratio.join("/")
        data[:ratio] = i.aspect_ratio
        data
      }
    end

    def destroy
      @image.destroy
      redirect_to :images , notice: "Image #{@image.name} deleted"
    end

    def update
      @image.name = params[:name]
      @image.tags = params[:tags]
      @image.edit_save(current_member.email)
      redirect_to image_path(@image) , notice: "Image updated"
    end

    def scale
      mini = MiniMagick::Image.new( @image.full_filename)
      mini.resize( "#{params[:scale]}%")
      @image.init_file_data
      @image.edit_save(current_member.email)
      redirect_to image_path(@image) , notice: "Image was scaled"
    end

    def crop
      mini = MiniMagick::Image.new( @image.full_filename)
      size = "#{params[:size_x]}x#{params[:size_y]}+#{params[:off_x]}+#{params[:off_y]}"
      mini.crop( size )
      @image.init_file_data
      @image.edit_save(current_member.email)
      redirect_to image_path(@image) , notice: "Image was resized"
    end

    def show
      @sections = Section.where(image_id: params[:id].to_i)
      @cards = Card.where(image_id: params[:id].to_i)
      @used = ((@cards.length > 0) || (@sections.length > 0))
      @image_data = @image.attributes
    end

    def copy
      image = @image.copy
      image.add_save(current_member.email)
      redirect_to image_path(image.id) , notice: "Image copied"
    end

    def create
      image = Image.create_new(params['filename'] ,params['tags'], params['image_file'])
      image.add_save current_member.email
      where_to  = determine_redirect(image)
      redirect_to where_to , notice: "New image created: #{image.name}"
    end

    private

    def set_image
      @image = Image.find(params[:id] || params[:image_id])
    end
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
