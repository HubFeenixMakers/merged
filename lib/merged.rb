require "merged/version"
require "merged/engine"

module Merged

  def self.load_data
    ["card_style" , "section_style" , "option"].each do |kind|
      # loading egine definitions first, can be overriden
      load_from kind , Engine.root.join("config/merged/#{kind}.yaml")
    end
    Page.load_pages
    Image.load_images
  end

  def self.load_from( kind , path )
    return unless File.exists?(path)
    clazz = "Merged::#{kind.camelcase}".constantize
    clazz.load(YAML.load_file( path ))
  end
end
