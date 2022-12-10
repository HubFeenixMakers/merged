require "merged/version"
require "merged/engine"

module Merged

  def self.load_data
    # pre-load data
    Option.all
    CardStyle.all
    SectionStyle.all
    Page.all
    Image.load_images
  end

  def self.load_from( kind , path )
    return unless File.exists?(path)
    clazz = "Merged::#{kind.camelcase}".constantize
    clazz.load(YAML.load_file( path ))
  end
end
