module Merged
  class Engine < ::Rails::Engine
    isolate_namespace Merged
    initializer "merged.assets.precompile" do |app|
      app.config.assets.precompile += %w( merged/application.js merged/application.css )
    end

  end
end
