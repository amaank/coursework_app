require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  def setup
    unused = Space.all.count + 1
    @space = Space.new(floor: unused, row: unused, column: unused)
  end

  test "valid space" do
    assert @space.valid?
  end

  test "invalid without floor" do
    @space.floor = nil
    refute @space.valid?
    assert @space.errors.key?(:floor)
  end

  test "invalid without row" do
    @space.row = nil
    refute @space.valid?
    assert @space.errors.key?(:row)
  end

  test "invalid without column" do
    @space.column = nil
    refute @space.valid?
    assert @space.errors.key?(:column)
  end

  test "invalid if duplicate floor, row and column combination" do
    used = Space.first
    assert used.valid?
    @space.floor = used.floor
    @space.row = used.row
    @space.column = used.column
    refute @space.valid?
    # Uniqueness validation is on the floor attribute, limited by row and column
    # Hence errors will be produced for the floor attribute only, in this case
    assert @space.errors.key?(:floor)
  end

  test "invalid if floor not greater than 0" do
    @space.floor = 0
    refute @space.valid?
    assert @space.errors.key?(:floor)
  end

  test "invalid if row not greater than 0" do
    @space.row = 0
    refute @space.valid?
    assert @space.errors.key?(:row)
  end

  test "invalid if column not greater than 0" do
    @space.column = 0
    refute @space.valid?
    assert @space.errors.key?(:column)
  end

  test "should be able to have many bookings" do
    assert_difference('@space.bookings.size', 2) do
      @space.save
      vehicle = Vehicle.new(registration_number: "XX00 XZZ", make: "Ford", model: "Focus", colour: "Blue")
      vehicle.save
      booking_one = Booking.new(space_id: @space.id, vehicle_id: vehicle.id, cost_type_id: CostType.first.id, date: 1010-10-10)
      booking_one.save
      booking_two = Booking.new(space_id: @space.id, vehicle_id: vehicle.id, cost_type_id: CostType.first.id, date: 1005-10-10)
      booking_two.save
    end
  end
end
