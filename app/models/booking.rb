class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :vehicle
  belongs_to :cost_type
end
