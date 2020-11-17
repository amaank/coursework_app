require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  def setup
    # Produce a value that will give a unique combination of floor, row and column.
    @unused = Space.all.count + 1
    # Create a valid 'space' object.
    @space = Space.new(floor: @unused, row: @unused, column: @unused)
  end

  test "valid space" do
    assert @space.valid?
  end

  test "invalid without floor" do
    # Remove value for floor attribute.
    @space.floor = nil
    refute @space.valid?
    # Check that object is invalid due to missing value for floor attribute.
    assert @space.errors.key?(:floor)
  end

  test "invalid without row" do
    # Remove value for row attribute.
    @space.row = nil
    refute @space.valid?
    # Check that object is invalid due to missing value for row attribute.
    assert @space.errors.key?(:row)
  end

  test "invalid without column" do
    # Remove value for column attribute.
    @space.column = nil
    refute @space.valid?
    # Check that object is invalid due to missing value for column attribute.
    assert @space.errors.key?(:column)
  end

  test "invalid if duplicate floor, row and column combination" do
    # Take an existing Space object.
    used = Space.first
    assert used.valid?
    # Set the floor, row and column attributes of @space to be the same as this object.
    # Therefore it will have the combination of floor, row and column.
    @space.floor = used.floor
    @space.row = used.row
    @space.column = used.column
    refute @space.valid?
    # Uniqueness validation is on the floor attribute, limited by row and column.
    # Hence errors will be produced for the floor attribute only, in this case.
    assert @space.errors.key?(:floor)
  end

  test "invalid if floor not greater than 0" do
    # Set value of floor attribute to not be greater than 0.
    @space.floor = 0
    refute @space.valid?
    # Check that the object is invalid due to invalid value for floor attribute.
    assert @space.errors.key?(:floor)
  end

  test "invalid if row not greater than 0" do
    # Set value of row attribute to not be greater than 0.
    @space.row = 0
    refute @space.valid?
    # Check that the object is invalid due to invalid value for row attribute.
    assert @space.errors.key?(:row)
  end

  test "invalid if column not greater than 0" do
    # Set value of column attribute to not be greater than 0.
    @space.column = 0
    refute @space.valid?
    # Check that the object is invalid due to invalid value for column attribute.
    assert @space.errors.key?(:column)
  end

  test "should be able to have many bookings" do
    # Test that the following code causes the number of associated booking objects to increase by 2.
    assert_difference('@space.bookings.size', 2) do
      # Save object to database.
      @space.save
      # Create new vehicle object.
      vehicle = vehicles(:one)
      # Save this to the database.
      vehicle.save
      # Create new booking object which references our space object.
      booking_one = Booking.new(space_id: @space.id, vehicle_id: vehicle.id, cost_type_id: CostType.first.id, date: Date.today)
      # Save this to the database.
      booking_one.save
      # Create another booking object which also references our space object.
      booking_two = Booking.new(space_id: @space.id, vehicle_id: vehicle.id, cost_type_id: CostType.first.id, date: Date.tomorrow)
      # And also save to the database.
      booking_two.save
    end
  end

  test "#display_space" do
    assert_equal("Floor: #{@unused}, Row: #{@unused}, Column: #{@unused}", @space.display_space)
  end

  test "#with_floor" do
    # Use the with_floor scope to create a collection of spaces with value 1 for floor attribute
    floor_one_spaces = Space.with_floor(1)
    # Create a list of all possible floors found in the above collection
    floors = floor_one_spaces.distinct.pluck(:floor)
    # Check that the only value for floor found is 1
    assert floors.length == 1
    assert floors[0] == 1
  end

  test "#with_row" do
    # Use the with_row scope to create a collection of spaces with value 1 for row attribute
    row_one_spaces = Space.with_row(1)
    # Create a list of all possible rows found in the above collection
    rows = row_one_spaces.distinct.pluck(:row)
    # Check that the only value for row found is 1
    assert rows.length == 1
    assert rows[0] == 1
  end
end
