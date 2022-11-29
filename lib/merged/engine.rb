module Merged
  class Engine < ::Rails::Engine
    isolate_namespace Merged
    initializer "merged.assets.precompile" do |app|
      app.config.assets.precompile += %w( config/merged_manifest.js )
      add_image_assets(app.config , "section_preview")
      add_image_assets(app.config , "card_preview")
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
