# config/initializers/monterail_api.rb
OlpApi::V1.configure("some.host.com", "secret") do |c|
  # let the magic happen - this will make use of ETag to skip unneed API calls
  c.use :http_cache, Rails.cache, :logger => Rails.logger

  # Active Support instrumentation
  c.use :instrumentation, :name => "external.monterail.olp"
end