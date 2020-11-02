class Space < ApplicationRecord
  # There may be 0 or more bookings for a particular parking space/slot.
  has_many :bookings
end
