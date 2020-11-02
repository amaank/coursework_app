class Booking < ApplicationRecord
  # One booking will belong to/be for one particular parking space.
  belongs_to :space
  # One booking will belong to/be for one particular vehicle.
  belongs_to :vehicle
  # One booking will belong to/be of one particular cost type/price.
  belongs_to :cost_type
end
