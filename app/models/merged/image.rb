  require "mini_magick"

module Merged
  class Image < ActiveYaml::Base

    set_root_path Rails.root

    fields  :name , :type , :size , :created_at , :height , :width

    def initialize(filename)
      if filename.is_a? Hash
        super(filename)
      else
        super({name: "newname"})
        init_from_file(filename)
      end
    end

    def init_from_file(filename)
      puts filename
      name , type = filename.split(".")
      self.name = name
      self.type = type
      fullname = Rails.root.join(asset_root,filename)
      file = File.new(fullname)
      image = MiniMagick::Image.new(fullname)
      self.width = image.width
      self.height = image.height
      self.created_at = file.birthtime
      self.size = (file.size/1024).to_i
    end

    def aspect_ratio
      ratio = self.width.to_f / self.height
      ratios = (1..9).collect{ |i|  ((ratio * i) - (ratio * i).round(0)).abs }
      min , min_index = ratios.each_with_index.min
      [(ratio *  (min_index + 1) ).to_i , (min_index + 1) ]
    end

    #save an io with given name (without ending, that is taken from io)
    #Should save to tmp first
    def self.create_new(filename , io)
      original , ending = io.original_filename.split("/").last.split(".")
      filename = original if( filename.blank? )
      full_filename = filename + "." + ending
      File.open(Rails.root.join("app/assets/images/cms/", full_filename), "wb") do |f|
        f.write( io.read )
      end
      Image.new( full_filename )
    end

    def destroy
      delete
      Image.save_all
    end

    def delete(reindex = true)
      Image.delete( self.id )
      section.reset_index if reindex
    end

    def save
      super
      Image.save_all
    end

    def self.save_all
      data = Image.the_private_records.collect {|obj| obj.attributes}
      File.write( Image.full_path , data.to_yaml)
      Image.reload
    end

    def assert_name
      image_root + "/" + self.name
    end

    private

    def asset_root
      "app/assets/images/" + image_root
    end

    def image_root
      "cms"
    end

  end
end
