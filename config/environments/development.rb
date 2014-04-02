V44::Application.configure do
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: ENV['email_host'],
    authentication: 'plain',
    enable_starttls_auto: true, # detects and uses STARTTLS
    user_name: ENV['google_email'],
    password: ENV['google_password']
  }

  #BetterErrors::Middleware.allow_ip! ENV['host_ip']

  #config.action_mailer.delivery_method = :letter_opener
  
  config.action_mailer.default_url_options = {host: ENV['email_host']}

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  #config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_controller.perform_caching = true
  
  #config.force_ssl = true
  config.log_level = :debug

  I18n.enforce_available_locales = false

end
