# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
require "rails/test_help"
require 'capybara/rails'
require 'capybara/minitest'
require "devise"
require "devise/test/integration_helpers"

Dir[Merged::Engine.root.join("test/helpers/**/*.rb")].each { |f| require f }

class ActionDispatch::IntegrationTest
  #include Devise::Test::IntegrationHelpers
  #include FactoryBot::Syntax::Methods
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Capybara::Minitest::Assertions  #### THIS LINE changes minitest assert_select #####

  # Reset sessions and driver between tests
  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
