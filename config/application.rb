require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Checkinar
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.default_locale = :es
    config.i18n.fallbacks = [:"es-MX"]
    config.time_zone = "Mexico City"
    config.active_record.default_timezone = :local
    config.eager_load_paths << Rails.root.join("lib")
    config.active_job.queue_adapter = :sidekiq
  end
end
