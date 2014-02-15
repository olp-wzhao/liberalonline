json.array!(@ridings) do |riding|
  json.extract! riding, 
  json.url riding_url(riding, format: :json)
end
