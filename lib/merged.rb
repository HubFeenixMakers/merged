require "merged/version"
require "merged/engine"

module Merged

  def self.load_data
    # pre-load data
    [OptionDefinition,  CardStyle, SectionStyle , PageStyle,
      Card , Section , Page ,  Image].each {|clazz| clazz.all }
  end

  def self.load_from( kind , path )
    return unless File.exists?(path)
    clazz = "Merged::#{kind.camelcase}".constantize
    clazz.load(YAML.load_file( path ))
  end
end
