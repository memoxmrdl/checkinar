# frozen_string_literal: true

require "test_helper"
require "webdrivers"
require "webdrivers/chromedriver"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["CI"]
    Capybara.register_driver :ci_headless_chrome do |app|
      options = ::Selenium::WebDriver::Chrome::Options.new

      options.add_argument("--headless")
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-dev-shm-usage")
      options.add_argument("--disable-gpu")

      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
    end

    Capybara.javascript_driver = :ci_headless_chrome

    driven_by :ci_headless_chrome
  else
    driven_by :selenium, using: :headless_chrome
  end
end
