class Space < ApplicationRecord
  # Filter all objects by floor
  scope :with_floor, -> (floor_num) { where(floor: floor_num) }
  # Filter all objects by row
  scope :with_row, -> (row_num) { where(row: row_num) }

  # There may be 0 or more bookings for a particular parking space/slot.
  # space not intended to be destroyable, thus no action taken on dependent bookings if destroyed.
  has_many :bookings

  # Ensure that values have been specified for all attributes.
  validates :floor, :row, :column, presence: true
  # A particular combination of floor, row and column denotes a unique space.
  validates :floor, uniqueness: { scope: [:row, :column] }
  # Prevent negative or zero values for floor, row and column.
  validates :floor, :row, :column, numericality: { greater_than: 0 }

  # Return string specifiying useful attribute values
  def display_space
   "#{I18n.t('spaces.index.floor')}: #{floor}, #{I18n.t('spaces.index.row')}: #{row}, #{I18n.t('spaces.index.column')}: #{column}"
  end

  # Check if a space is booked for a particular date
  def is_booked(date)
    self.bookings.with_date(date).length == 1
  end
end
