source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.7"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "8.1.1"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"
# Use SCSS for stylesheets
gem 'sass-rails'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", '>= 1.4.4', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Other gems
gem 'chronic'
gem 'materialize-sass'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'cancancan'
gem 'validates_timeliness'
gem 'time_date_helpers'
gem 'carrierwave'
gem 'will_paginate'
gem 'vuejs-rails'

group :development, :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem 'test-unit'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'hirb'
  gem 'faker'
  gem 'populator'
  gem 'factory_bot_rails'
  gem 'simplecov'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'minitest'
  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
  gem 'launchy'
end

group :development do
  # # Access an IRB console on exception pages or by using <%= console %> anywhere in the code. [https://github.com/rails/web-console]
  gem "web-console"
  gem 'listen'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"
  gem 'spring-watcher-listen'
end
