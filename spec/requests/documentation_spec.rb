require 'spec_helper'

describe 'api documentation' do
  it 'finds something at the api root' do
    get '/api'
    last_response.status.should == 200
  end

  it 'can load swagger documentation' do
    get '/api/swagger_doc'
    last_response.status.should == 200
    json_response = JSON.parse(last_response.body)
    json_response['apiVersion'].should == 'v1'
    json_response['apis'].size.should > 0
  end
end
