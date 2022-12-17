source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in merged.gemspec.
gemspec

gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'rspec-rails' , require: "rspec-rails"
gem 'haml-rails' , require: "haml-rails"
gem "tailwindcss-rails"
gem "importmap-rails"
gem "sprockets-rails"

gem "ruby2js" , path: "../ruby2js"

group :development, :test do
  gem "capybara"
  gem 'guard-rspec', require: false
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "puma"
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
