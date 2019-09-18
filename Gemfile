# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 6.0.0"

gem "administrate", git: "https://github.com/thoughtbot/administrate.git"
gem "devise"
gem "devise-i18n"
gem "fast_jsonapi"
gem "jbuilder", "~> 2.7"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "role_model"
gem "oj"
gem "sass-rails", "~> 5"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "haml-rails", "~> 2.0"
gem "interactor-rails"
gem "pundit"
gem "rails-i18n"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "pry"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop-rails_config"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "letter_opener"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
