module Merged
  class Image
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    @@images = {}

    attr_reader :name , :type , :size , :created_at , :updated_at

    def initialize(filename)
      puts "New Image #{filename}"
      @name , @type = filename.split(".")
      file = File.new(Rails.root.join(Image.asset_root,filename))
      @created_at = file.birthtime
      @updated_at = file.ctime
      @size = (file.size/1024).to_i
    end

    def self.all
      return @@images unless @@images.empty?
      Dir[Rails.root.join Image.asset_root + "*.*"].each do |f|
        file = f.split("/").last
        self.add( file )
      end
      @@images
    end

    #save an io with given name (without ending, that is taken from io)
    def self.create_new(filename , io)
      original , ending = io.original_filename.split("/").last.split(".")
      filename = original if( filename.blank? )
      full_filename = filename + "." + ending
      File.open(Rails.root.join(Image.asset_root, full_filename), "wb") do |f|
        f.write( io.read )
      end
      self.add( full_filename )
    end

    def self.asset_root
      "app/assets/images/" + root
    end
    
    def self.root
      "cms"
    end

    private
    def self.add(filename)
      key = filename.split(".").first
      @@images[key] = Image.new(filename)
    end
  end
end
