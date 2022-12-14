require "mini_magick"

module Merged
  class Image
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    cattr_reader :all
    @@all = {}

    def self.load_images()
      glob = Rails.root.join Image.asset_root + "/*.*"
      Dir[glob].each do |f|
        file = f.split("/").last
        Image.new( file )
      end
    end

    attr_reader :name , :type , :size , :created_at , :height , :width

    def initialize(filename)
      @name , @type = filename.split(".")
      fullname = Rails.root.join(Image.asset_root,filename)
      file = File.new(fullname)
      image = MiniMagick::Image.new(fullname)
      @width = image.width
      @height = image.height
      @created_at = file.birthtime
      @size = (file.size/1024).to_i
      @@all[@name] = self
    end

    def aspect_ratio
      ratio = @width.to_f / @height
      ratios = (1..9).collect{ |i|  ((ratio * i) - (ratio * i).round(0)).abs }
      min , min_index = ratios.each_with_index.min
      [(ratio *  (min_index + 1) ).to_i , (min_index + 1) ]
    end

    #save an io with given name (without ending, that is taken from io)
    def self.create_new(filename , io)
      original , ending = io.original_filename.split("/").last.split(".")
      filename = original if( filename.blank? )
      full_filename = filename + "." + ending
      File.open(Rails.root.join(Image.asset_root, full_filename), "wb") do |f|
        f.write( io.read )
      end
      Image.new( full_filename )
    end

    def self.asset_root
      "app/assets/images/" + image_root
    end

    def self.image_root
      "cms"
    end

  end
end
