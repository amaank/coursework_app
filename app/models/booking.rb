class Booking < ApplicationRecord
  # One booking will belong to/be for one particular parking space.
  belongs_to :space
  # One booking will belong to/be for one particular vehicle.
  belongs_to :vehicle
  # One booking will belong to/be of one particular cost type/price.
  belongs_to :cost_type

  # Validations.
  validates_associated :space, :vehicle, :cost_type
  validates :space, :vehicle, :cost_type, numericality: { only_integer: true }
  validates :space, :vehicle, :cost_type, :date, presence: true

  # Prevent a particular space from being booked twice on the same day.
  validates :space, uniqueness: { scope: :date,
    message: I18n.t('bookings.validation.invalid_space') }

  # Prevent a particular vehicle from having multiple bookings on the same day.
  validates :vehicle, uniqueness: { scope: :date,
    message: I18n.t('bookings.validation.invalid_vehicle') }
end
