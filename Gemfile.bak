source "https://rubygems.org"
ruby '2.0.0'

gem "rails", "4.0.0"
gem "haml-rails"
gem "mongoid", github: "mongoid/mongoid"

gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'mini_magick', :git => 'git://github.com/probablycorey/mini_magick.git'

gem "therubyracer", platforms: :ruby
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 1.2"
gem "bootstrap-sass"
gem 'bootstrap-datepicker-rails'
gem "font-awesome-sass-rails"
gem 'kaminari'

group :assets do
  gem 'modernizr-rails'
  gem "sprockets-rails", github: "rails/sprockets-rails"
  gem "sass-rails", github: "rails/sass-rails"
  gem "coffee-rails", github: "rails/coffee-rails"
  gem "therubyracer", platforms: :ruby
  gem "uglifier"
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
end

group :development do
  gem "pry"
  gem "quiet_assets"
  gem "thin"
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
end

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'terminal-notifier-guard'
  gem 'guard'
  gem "guard-rspec"
end

group :test do
  gem "mongoid-rspec"
  gem "ffaker"
  gem "simplecov", require: false
  gem "database_cleaner"
  gem 'rb-inotify'
  gem 'libnotify', :require => false
end

gem "simple_form", github: "plataformatec/simple_form"
gem "devise", "~> 3.0.0"
gem "cancan"
gem "omniauth"
gem "omniauth-facebook"
#gem "omniauth-twitter"
gem "devise_invitable"
gem "hashugar", github: "alex-klepa/hashugar"

gem "money"
gem "mongoid_search"
gem 'geocoder',         github: 'alexreisner/geocoder'

gem 'mandrill-api'

#gem 'fastercsv' # Only required on Ruby 1.8 and below
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

gem 'newrelic_rpm'
gem "best_in_place"
