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


    attr_reader :name , :type , :size , :created_at , :updated_at

    def initialize(filename)
      @name , @type = filename.split(".")
      file = File.new(Rails.root.join(Image.asset_root,filename))
      @created_at = file.birthtime
      @updated_at = file.ctime
      @size = (file.size/1024).to_i
      @@all[@name] = self
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
