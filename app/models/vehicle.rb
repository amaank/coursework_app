class Vehicle < ApplicationRecord
  # There may be 0 or more bookings made for a particular vehicle.
  # But these should be removed if the vehicle is unregistered from the site.
  has_many :bookings, dependent: :destroy
end
