require "mini_magick"
require "fileutils"

module Merged
  class Image < ActiveBase

    set_root_path Rails.root

    fields  :name , :tags , :type , :size ,  :height , :width

    def change_name
      name
    end

    def aspect_ratio
      ratio = self.ratio
      ratios = (1..9).collect{ |i|  ((ratio * i) - (ratio * i).round(0)).abs }
      min , min_index = ratios.each_with_index.min
      [(ratio *  (min_index + 1) ).round(0).to_i , (min_index + 1) ]
    end

    def ratio
      return 0 unless self.height
      self.width.to_f / self.height
    end

    def copy()
      image = Image.new name: "#{name}_copy" , type: type , tags: (tags || "")
      Image.insert(image) # assigns next id
      FileUtils.cp full_filename , image.full_filename
      image.init_file_data
      image
    end

    #save an io as new image. The filename is the id, type taken from io
    def self.create_new(name , tags,  io)
      original , ending = io.original_filename.split("/").last.split(".")
      name = original if( name.blank? )
      image = Image.new name: name , type: ending , tags: (tags || "")
      self.insert(image) # assigns next id
      full_filename = image.id.to_s + "." + ending
      File.open(Rails.root.join("app/assets/images/cms/", full_filename), "wb") do |file|
        file.write( io.read )
      end
      image.init_file_data
      image
    end

    def init_file_data
      image = MiniMagick::Image.new(full_filename)
      self.width = image.width
      self.height = image.height
      self.size = (image.size/1024).to_i
    end

    def destroy(editor)
      File.delete self.full_filename
      delete_save!(editor)
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

    def self.root
      "app/assets/images/cms"
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
