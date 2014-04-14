# app/controllers/api/api.rb
module V1
  class Base < ApplicationAPI
    #version 'v1', :using => :path

    # mount Tokens
    # mount Documents
    mount SampleAPI
    #mount API::V1::SecretAPI

    add_swagger_documentation base_path: "/api",
                              api_version: 'v1',
                              hide_documentation_path: true
  end

  #Base = Rack::Builder.new do
  #  use API::Logger
  #  run API::Olp
  #end
end


