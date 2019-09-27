# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 6.0.0"

gem "administrate", git: "https://github.com/thoughtbot/administrate.git"
gem "activestorage-validator"
gem "aws-sdk-s3", require: false
gem "bcrypt", "~> 3.1.7"
gem "devise"
gem "devise-i18n"
gem "fast_jsonapi"
gem "haml-rails", "~> 2.0"
gem "image_processing", "~> 1.2"
gem "interactor-rails"
gem "jwt"
gem "kaminari"
gem "mini_magick"
gem "oj"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "pundit"
gem "rails-i18n"
gem "role_model"
gem "sidekiq"
gem "slack-notifier"
gem "webpacker", "~> 4.0"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "pry-rails"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "bullet"
  gem "i18n-debug"
  gem "memory_profiler"
  gem "rack-mini-profiler"
  gem "stackprof"
  gem "brakeman"
  gem "bundle-audit"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop-rails_config"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "letter_opener"
  gem "annotate"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "mocha"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "json_matchers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
