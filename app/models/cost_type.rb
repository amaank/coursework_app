class CostType < ApplicationRecord
  # There may be 0 or more bookings which cost the same amount.
  has_many :bookings
end
