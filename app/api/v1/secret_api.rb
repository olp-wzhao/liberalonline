module V1
  class SecretAPI < Base
    guard_all!  # Requires a valid OAuth 2 Access Token to use all Endpoints

    get "secret1" do
      { :secret1 => "Hi, #{current_user.email}" }
    end

    get "secret2" do
      { :secret2 => "only smart guys can see this ;)" }
    end
  end
end