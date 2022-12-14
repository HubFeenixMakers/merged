require_relative "lib/merged/version"

Gem::Specification.new do |spec|
  spec.name        = "merged"
  spec.version     = Merged::VERSION
  spec.authors     = ["Torsten"]
  spec.email       = ["torsten@rubydesign.fi"]
  spec.homepage    = "https://github.com/HubFeenixMakers/merged"
  spec.summary     = "A file based cmas the integrates with rails workflow"
  spec.description = "Changes propagate in the normal development cycle, with git, possible branches, possible staging, possible reviews and controlled deploys."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/HubFeenixMakers/merged"
  spec.metadata["changelog_uri"] = "https://github.com/HubFeenixMakers/merged"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"
  spec.add_dependency "haml-rails"
  spec.add_dependency "git"
  spec.add_dependency "redcarpet"
  spec.add_dependency "active_hash"
  spec.add_dependency "mini_magick"
end
