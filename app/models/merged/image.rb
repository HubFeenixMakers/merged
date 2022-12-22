  require "mini_magick"

module Merged
  class Image < ActiveYaml::Base

    set_root_path Rails.root

    fields  :name , :tags , :type , :size , :created_at , :height , :width

    def aspect_ratio
      ratio = self.ratio
      ratios = (1..9).collect{ |i|  ((ratio * i) - (ratio * i).round(0)).abs }
      min , min_index = ratios.each_with_index.min
      [(ratio *  (min_index + 1) ).to_i , (min_index + 1) ]
    end

    def ratio
      self.width.to_f / self.height
    end

    #save an io as new image. The filename is the id, type taken from io
    def self.create_new!(name , tags,  io)
      original , ending = io.original_filename.split("/").last.split(".")
      name = original if( name.blank? )
      image = Image.new name: name , type: ending , tags: (tags || "")
      self.insert(image) # assigns next id
      full_filename = image.id.to_s + "." + ending
      File.open(Rails.root.join("app/assets/images/cms/", full_filename), "wb") do |file|
        file.write( io.read )
      end
      image.init_file_data
      image.save
      image
    end

    def init_file_data
      image = MiniMagick::Image.new(full_filename)
      self.width = image.width
      self.height = image.height
      file =  File.open( full_filename )
      self.created_at = file.birthtime
      self.size = (file.size/1024).to_i
    end

    def destroy
      delete
      File.delete self.full_filename
      Image.save_all
    end

    def delete
      Image.delete( self.id )
    end

    def asset_name
      image_root + "/" + self.id.to_s + "." + self.type
    end

    def full_filename
      full_filename = self.id.to_s + "." + self.type
      Rails.root.join(asset_root, full_filename)
    end

    def self.transform
      Image.all.each do |image|
        last = image.name.split.last
        image.tags = ""
        ["wide", "small" , "big" , "room"].each do |tag|
          if(last == tag)
            image.name = image.name.gsub(last,"").strip
            image.tags = last
          end
        end
        image.save
      end
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
