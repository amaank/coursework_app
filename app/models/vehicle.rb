class Vehicle < ApplicationRecord
  # Filter all objects by user
  scope :user_vehicles, -> (user) { where(['user_id = ?', user.id]) }

  belongs_to :user
  # There may be 0 or more bookings made for a particular vehicle.
  # But these should be removed if the vehicle is unregistered from the site.
  has_many :bookings, dependent: :destroy

  # Ensure that the registration number has a valid format (based on latest UK reg. number format).
  # https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/359317/INF104_160914.pdf
  validates :registration_number, format: { with: /\A[A-Za-z]{2}\d{2}\s{1}[A-Za-z]{3}\z/,
    message: I18n.t('vehicles.validation.invalid_reg_number') }
  # Ensure values have been provided for registration number, make and model - but not colour.
  validates :registration_number, :make, :model, presence: true
  # Ensure that the required strings (which have no specific format) are at least 2 characters long.
  validates :make, :model, length: { minimum: 2 }
  # Ensure the reg. number/number plate has not already been registered on the site.
  validates :registration_number, uniqueness: { case_sensitive: false }


end
