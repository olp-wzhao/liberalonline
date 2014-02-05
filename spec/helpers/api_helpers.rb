module ApiHelpers
  def get_webadmin_auth_token
    post api_v1_tokens_url, params.to_json, {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      binding.pry
  end
end