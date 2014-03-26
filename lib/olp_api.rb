# lib/monterail-api.rb
module OlpApi
  module V1
    class ClientNotConfigured < Exception; end

    def self.configure(host, api_key, &block)
      @api = Her::API.new

      @api.setup :url => "http://#{host}/api/olp" do |c|
        # we love JSON, we really do
        c.use FaradayMiddleware::EncodeJson
        c.use Her::Middleware::AcceptJSON
        c.use Her::Middleware::FirstLevelParseJSON

        # simple header based authorizaiton
        c.authorization :token, api_key

        # allow for customizing faraday connection
        yield c if block_given?

        # inject default adapter unless in test mode
        c.adapter Faraday.default_adapter unless c.builder.handlers.include?(Faraday::Adapter::Test)
      end

      # This is very important. Due to way Her currently works
      # model files need to be required after configuring the API
      require "hussars/models"
    end

    def self.api
      # raise exception if somehow model classes gets required
      # before the API is configured
      raise ClientNotConfigured.new("Monterail") unless @api
      @api
    end
  end
end