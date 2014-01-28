json.array!(@riding_addresses) do |riding_address|
  json.extract! riding_address, 
  json.url riding_address_url(riding_address, format: :json)
end
