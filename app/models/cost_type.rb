class CostType < ApplicationRecord
  # There may be 0 or more bookings which cost the same amount.
  has_many :bookings

  # Ensure that values have been specified for all attributes.
  validates :name, :price, :description, presence: true
  # Ensure that name and description strings are at least 2 characters long.
  validates :name, :description, length: { minimum: 2 }
  # Prevent multiple cost types with the same name, regardless of case.
  validates :name, uniqueness: { case_sensitive: false }
  # Prevent negative or zero values for price.
  validates :price, numericality: { greater_than: 0.0 }

end
