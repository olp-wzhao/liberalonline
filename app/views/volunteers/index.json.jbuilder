json.array!(@volunteers) do |volunteer|
  json.extract! volunteer, 
  json.url volunteer_url(volunteer, format: :json)
end
