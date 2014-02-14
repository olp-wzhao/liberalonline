json.array!(@petitions) do |petition|
  json.extract! petition, :id
  json.url petition_url(petition, format: :json)
end
