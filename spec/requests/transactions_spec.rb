require 'spec_helper'

describe "Transactions" do
  let(:webadmin) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:transaction) { FactoryGirl.create(:transaction) }
  before(:each) do
    params = { email: webadmin.email, password: webadmin.password }
      post api_v1_tokens_url, params.to_json, {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    @token = JSON.parse(response.body)["token"]
  end

  it 'authenticates a registered admin user' do
    params = { email: webadmin.email, password: webadmin.password }
    post api_v1_tokens_url, params.to_json, {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    JSON.parse(response.body).should_not == nil
    response.status.should be(200)
  end

  describe "GET /transactions/" do
    it "accepts a transaction id and returns json of record" do
      get "#{transactions_path}/#{transaction.id}.json?auth_token=#{@token}"
      
      response.body.should_not be_empty

    end
  end

  describe "POST /transaction" do
    it "accepts JSON data" do
      post "#{transactions_path}/?auth_token=#{@token}", transaction.to_json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      response.header['Content-Type'].should include 'application/json'
      response.status.should be(201)
      #assert_redirected_to document_url(Document.last)
    end

    it "returns the _id field" do
      post "#{transactions_path}/?auth_token=#{@token}", transaction.to_json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      json = JSON.parse(response.body)
      json.should_not == nil
      json["transaction_id"].should_not == nil
    end

    it "should create a user when email is unique" do
      post "#{transactions_path}/?auth_token=#{@token}", transaction.to_json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      binding.pry
    end
  end

end
 