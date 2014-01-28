json.array!(@transactions) do |transaction|
  json.extract! transaction, :created_at, :updated_at, :prefix, :last_name, :first_name, :street_address, :postal_code, :city, :telephone, :email, :card_name,  :card_security, :card_expiry, :card_reference, :card_type, :personal, :company_name, :user_ip, :origin_url, :target_url, :promo_code, :gateway_response, :home_riding, :type, :comments, :complete
  json.url transaction_url(transaction, format: :json)
end
