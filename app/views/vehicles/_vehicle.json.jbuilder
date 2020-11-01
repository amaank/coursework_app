json.extract! vehicle, :id, :registration_number, :make, :model, :colour, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
