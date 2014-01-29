require 'spec_helper'

describe "Documents" do

  describe "GET /documents" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get documents_path
      response.status.should be(200)
    end
  end

  describe "POST /documents" do

    let(:webadmin) { FactoryGirl.create(:user) }
    before (:each) do
      params = { email: webadmin.email, password: webadmin.password }
      post api_v1_tokens_url, params.to_json, {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      @token = JSON.parse(response.body)["token"]
    end

    #let(:auth_token) {}
  
    it "accepts JSON data" do
      post "#{documents_path}/?auth_token=#{@token}", FactoryGirl.create(:document).to_json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      #response.header['Content-Type'].should include 'text/javascript'
      
      response.status.should be(201)
      #assert_redirected_to document_url(Document.last)
    end

    it"accepts JSON document" do
      json = File.read("spec/fixtures/valid_document.json")
      post "#{documents_path}/?auth_token=#{@token}", json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    end

  end


end
