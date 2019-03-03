json.extract! location, :id, :name, :city, :state, :created_at, :updated_at
json.url location_url(location, format: :json)
