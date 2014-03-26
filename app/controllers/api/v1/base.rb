# app/controllers/api/api.rb

module API
  module V1
    class Base < Grape::API

      mount API::V1::Documents
      #mount Olp::Commen

      add_swagger_documentation

    end

    #Base = Rack::Builder.new do
    #  use API::Logger
    #  run API::Olp
    #end
  end
end


