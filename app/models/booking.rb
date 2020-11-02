class Booking < ApplicationRecord
  # One booking will belong to/be for one particular parking space.
  belongs_to :space
  # One booking will belong to/be for one particular vehicle.
  belongs_to :vehicle
  # One booking will belong to/be of one particular cost type/price.
  belongs_to :cost_type

  # Validations.
  # DO I NEED VALIDATES_ASSOCIATED FOR VEHICLE? (REMEMBER, NEVER PUT VALIDATES_ASSOCIATED ON BOTH ENDS OF AN ASSOCIATION)
  # Not sure if I need this validation - I plan on providing a drop-down menu or (perhaps later, a bit more complex) an interactive diagram which will autofill the following fields
  validates :space, :vehicle, :cost_type, numericality: { only_integer: true }
  # Need to validate presence of any fields except date? Do I need to validate the presence of the foreign keys and the objects associated with those, or is that done automatically?
  validates :date, presence: true

  # Prevent a particular space from being booked twice on the same day.
  # Double-check that the following validation makes sense.
  validates :space, uniqueness: { scope: :date,
    message: "A parking space cannot be booked twice for one day." }

    # Double-check that the following validation makes sense.
  validates :vehicle, uniqueness: { scope: :date,
    message: "A vehicle cannot be booked twice for one day." }
end
