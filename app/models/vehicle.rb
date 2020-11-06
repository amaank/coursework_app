class Vehicle < ApplicationRecord
  # There may be 0 or more bookings made for a particular vehicle.
  # But these should be removed if the vehicle is unregistered from the site.
  has_many :bookings, dependent: :destroy

  # Validations.
  validates :registration_number, format: { with: /\A[A-Za-z]{2}\d{2}\s{1}[A-Za-z]{3}\z/,
    message: I18n.t('vehicles.validation.invalid_reg_number') }

  validates :registration_number, :make, :model, presence: true
  validates :make, :model, length: { minimum: 2 }

  # Ensure the reg. number/number plate has not already been registered on the site.
  validates :registration_number, uniqueness: { case_sensitive: false }
end
