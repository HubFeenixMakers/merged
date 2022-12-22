source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in merged.gemspec.
gemspec

gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'haml-rails' , require: "haml-rails"
gem "tailwindcss-rails"
gem "importmap-rails"
gem "sprockets-rails"
gem "devise"

gem "ruby2js" , path: "../ruby2js"

group :development, :test do
  gem "capybara"
  gem 'guard-rspec', require: false
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "puma"
  gem 'rspec-rails' , require: "rspec-rails"
  gem 'guard-minitest'
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
