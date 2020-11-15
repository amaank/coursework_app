class Booking < ApplicationRecord
  # One booking will belong to/be for one particular parking space.
  belongs_to :space
  # One booking will belong to/be for one particular vehicle.
  belongs_to :vehicle
  # One booking will belong to/be of one particular cost type/price.
  belongs_to :cost_type

  # Ensure that values have been specified for all attributes.
  validates :space_id, :vehicle_id, :cost_type_id, :date, presence: true
  # Prevent a particular space from being booked twice on the same day.
  validates :space_id, uniqueness: { scope: :date,
    message: I18n.t('bookings.validation.invalid_space') }
  # Prevent a particular vehicle from having multiple bookings on the same day.
  validates :vehicle_id, uniqueness: { scope: :date,
    message: I18n.t('bookings.validation.invalid_vehicle') }
  # Only allow the date to be within a certain range.
  validate :date_limit

  def date_limit
    # To prevent bookings being made for dates in the past.
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
    # To prevent bookings being made more than 7 days in advance.
    if date.present? && date > (Date.today + 7.days)
      errors.add(:date, "can't be more than a week from today")
    end
  end
end
