class Space < ApplicationRecord
  # There may be 0 or more bookings for a particular parking space/slot.
  has_many :bookings

  # Ensure that values have been specified for all attributes.
  validates :floor, :row, :column, presence: true
  # A particular combination of floor, row and column denotes a unique space.
  validates :floor, uniqueness: { scope: [:row, :column] }
end
