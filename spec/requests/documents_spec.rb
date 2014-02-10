require 'spec_helper'

describe "Documents" do
  
  let(:event) { FactoryGirl.create(:event) }
  let(:document) { FactoryGirl.create(:document) }
  before(:each) do
    User.any_instance.stub(:geocode).and_return([1,1]) 
  end

  describe "GET /admin/documents" do
    it "refuses unauthenticated requests" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_documents_list_path
      response.status.should be(300)
      binding.pry
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
      post "#{documents_path}/?auth_token=#{@token}", document.to_json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      #response.header['Content-Type'].should include 'text/javascript'
      
      binding.pry
      response.status.should be(201)
      #assert_redirected_to document_url(Document.last)
    end

    it"accepts JSON document" do
      json = File.read("spec/fixtures/valid_document.json")
      post "#{documents_path}/?auth_token=#{@token}", json,  {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      binding.pry
    end

  end


end
