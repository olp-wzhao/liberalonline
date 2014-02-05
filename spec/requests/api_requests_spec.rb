require 'spec_helper'

describe "Api Authentication" do
  let(:webadmin) { FactoryGirl.create(:user) }
  subject { webadmin }

  it 'authenticates a registered admin user' do
    params = { email: webadmin.email, password: webadmin.password }
    post api_v1_tokens_url, params.to_json, {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    response.status.should be(200)
  end
end