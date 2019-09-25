# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"
require "json_matchers/minitest/assertions"

Dir[Rails.root.join("test/support/**/*test_helper.rb")].each { |f| require f }

JsonMatchers.schema_root = "test/support/schemas"
Minitest::Test.send(:include, JsonMatchers::Minitest::Assertions)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include AuthorizationTestHelper
end
