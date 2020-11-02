class Vehicle < ApplicationRecord
  # There may be 0 or more bookings made for a particular vehicle.
  # But these should be removed if the vehicle is unregistered from the site.
  has_many :bookings, dependent: :destroy

  # Validations.
  # ADD VALIDATION FOR NUMBER PLATE/REGISTRATION NUMBER USING 'FORMAT' HELPER
  # FOR NUMBER PLATE FORMAT: https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/359317/INF104_160914.pdf
  # SEE IF YOU CAN TAKE OLD NUMBER PLATE FORMAT INTO ACCOUNT I.E. FOR OLDER CARS
  validates :make, :model, :colour, length: { minimum: 2 }
  validates :registration_number, :make, :model, presence: true
  # Ensure the reg. number/number plate has not already been registered on the site.
  validates :registration_number, uniqueness: { case_sensitive: false } # Is this correct? Made case_sensitive false to prevent the same number plate being added twice if it has different cases.
end
