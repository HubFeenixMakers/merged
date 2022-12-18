require "active_hash"
require "ruby2js"
require "ruby2js/es2015"
require "ruby2js/filter/functions"
require "ruby2js/haml"
require "ruby2js/filter/vue"

module Merged
  class Engine < ::Rails::Engine
    isolate_namespace Merged
    initializer "merged.assets.precompile" do |app|
      app.config.assets.precompile += %w( merged/merged.css merged/vue.js merged/vue.min.js merged/merged_logo)
      add_image_assets(app.config , "section_preview")
      add_image_assets(app.config , "card_preview")
    end

    initializer "after_initialize" do |app|
      ActiveSupport::Reloader.to_prepare do
        Merged.load_data
      end
    end

    private
    def add_image_assets(config ,  sub_dir )
      dir = Dir.new(Engine.root.join("app/assets/images/merged/" , sub_dir))
      dir.children.each do |file|
        kid = "merged/" + sub_dir + "/" + file
        config.assets.precompile << kid
      end
    end
  end
end
