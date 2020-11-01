json.extract! booking, :id, :space_id, :vehicle_id, :cost_type_id, :date, :created_at, :updated_at
json.url booking_url(booking, format: :json)
