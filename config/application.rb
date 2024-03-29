require File.expand_path('../boot', __FILE__)

#require 'rails/all'
require 'action_controller/railtie'
require 'action_mailer/railtie'
#require 'rails/test_unit/railtie'
require 'sprockets/railtie'
#require 'carrierwave/mongoid'

require 'bson'
require 'moped'

Moped::BSON = BSON

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module V44
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    #config.i18n.default_locale = 'en-CA'

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    
    config.secret_key_base = 'blipblapblup'

    #grape api configuration
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.paths.add 'app/api', glob: '**/*.rb'
    config.paths.add 'app/services', glob: '**/*.rb'
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.autoload_paths += Dir["#{Rails.root}/app/api/*"]
    config.autoload_paths += Dir["#{Rails.root}/app/services/*"]


    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
      end
    end

  end
end
