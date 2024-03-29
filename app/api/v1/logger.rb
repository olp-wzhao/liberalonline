#app/controllers/api/logger.rb
class API::Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    payload = {
        remote_addr:    env['REMOTE_ADDR'],
        request_method: env['REQUEST_METHOD'],
        request_path:   env['PATH_INFO'],
        request_query:  env['QUERY_STRING'],
        x_organization: env['HTTP_X_ORGANIZATION']
    }

    ActiveSupport::Notifications.instrument "grape.request", payload do
      @app.call(env).tap do |response|
        payload[:params] = env["api.endpoint"].params.to_hash
        payload[:params].delete("route_info")
        payload[:params].delete("format")
        payload[:response_status] = response[0]
      end
    end
  end
end