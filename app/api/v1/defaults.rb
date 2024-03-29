# app/controllers/api/v1/defaults.rb
module API
  module V1
    module Defaults
      # if you're using Grape outside of Rails, you'll have to use Module#included hook
      extend ActiveSupport::Concern

      included do
        # common Grape settings
        version 'v1'
        format :json

        # global handler for simple not found case
        # rescue_from ActiveRecord::RecordNotFound do |e|
        #   error_response(message: e.message, status: 404)
        # end

        helpers do
          def authenticate!
            error!('Unauthorized. Invalid or expired token', 401) unless current_user
          end

          def current_user
            user_email = params[:user_email].presence
            user = user_email && User.find_by(email: user_email)
            if user && Devise.secure_compare(user.authentication_token, params[:user_token])
              user
            else
              false
            end
          end
        end

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            #Raven.capture_exception(e)
            error_response(message: "Internal server error", status: 500)
          end
        end

        # HTTP header based authentication
        before do
          error!('Unauthorized', 401) unless current_user #headers['Authorization'] == "some token"
        end
      end
    end
  end
end