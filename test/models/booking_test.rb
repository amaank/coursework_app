require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    # Make use of an existing record in 'spaces' that should always be present.
    @space = Space.first
    # Create new vehicle object.
    @vehicle = vehicles(:one)
    # Save object to the database.
    @vehicle.save
    # Make use of an existing record in 'cost_types' that should always be present.
    @cost_type = CostType.first
    # Create a valid 'booking' object.
    @booking = Booking.new(space_id: @space.id, vehicle_id: @vehicle.id, cost_type_id: @cost_type.id, date: Date.today)
  end

  test "valid booking" do
    assert @booking.valid?
  end

  test "invalid if referenced space is invalid" do
    # Assign a space_id value which does not correspond to an existing object.
    @booking.space_id = Space.last.id + 1
    refute @booking.valid?
    # Check that object is invalid due to the referenced space object.
    assert @booking.errors.key?(:space)
  end

  test "invalid if referenced vehicle is invalid" do
    # Assign a vehicle_id value which does not correspond to an existing object.
    @booking.vehicle_id = Vehicle.last.id + 1
    refute @booking.valid?
    # Check that object is invalid due to the referenced vehicle object.
    assert @booking.errors.key?(:vehicle)
  end

  test "invalid if referenced cost_type is invalid" do
    # Assign a cost_type_id value which does not correspond to an existing object.
    @booking.cost_type_id = CostType.last.id + 1
    refute @booking.valid?
    # Check that object is invalid due to the referenced cost_type object.
    assert @booking.errors.key?(:cost_type)
  end

  test "invalid without space_id" do
    # Remove the value for space_id attribute.
    @booking.space_id = nil
    refute @booking.valid?
    # Check that object is invalid due to missing value for space_id attribute.
    assert @booking.errors.key?(:space_id)
  end

  test "invalid without vehicle_id" do
    # Remove the value for vehicle_id attribute.
    @booking.vehicle_id = nil
    refute @booking.valid?
    # Check that object is invalid due to missing value for vehicle_id attribute.
    assert @booking.errors.key?(:vehicle_id)
  end

  test "invalid without cost_type_id" do
    # Remove the value for cost_type_id attribute.
    @booking.cost_type_id = nil
    refute @booking.valid?
    # Check that object is invalid due to missing value for cost_type_id attribute.
    assert @booking.errors.key?(:cost_type_id)
  end

  test "invalid without date" do
    # Remove the value for date attribute.
    @booking.date = nil
    refute @booking.valid?
    # Check that object is invalid due to missing value for date attribute.
    assert @booking.errors.key?(:date)
  end

  test "invalid if duplicate space_id and date combination" do
    # Save object to the database.
    @booking.save
    # Create new vehicle object.
    new_vehicle = vehicles(:two)
    # Save object to the database.
    new_vehicle.save
    # Create new booking object with same space_id and date values as our booking.
    new_booking = Booking.new(space_id: @booking.space_id, vehicle_id: new_vehicle.id, cost_type_id: CostType.second.id, date: @booking.date)
    refute new_booking.valid?
    # Uniqueness validation is on the space_id attribute, limited by date
    # Hence errors will be produced for the space_id attribute only, in this case
    assert new_booking.errors.key?(:space_id)
  end

  test "invalid if duplicate vehicle_id and date combination" do
    # Save object to the database.
    @booking.save
    # Create new booking object with same vehicle_id and date values as our booking.
    new_booking = Booking.new(space_id: Space.second.id, vehicle_id: @booking.vehicle_id, cost_type_id: CostType.second.id, date: @booking.date)
    refute new_booking.valid?
    # Uniqueness validation is on the vehicle_id attribute, limited by date
    # Hence errors will be produced for the vehicle_id attribute only, in this case
    assert new_booking.errors.key?(:vehicle_id)
  end

  test "invalid if date in past" do
    # Set date attribute value to be in the past.
    @booking.date = Date.yesterday
    refute @booking.valid?
    # Check that object is invalid due to invalid date attribute.
    assert @booking.errors.key?(:date)
  end

  test "invalid if date more than 7 days from current date" do
    # Set date attribute value to be more than 7 days from current date.
    @booking.date = Date.today + 8.days
    refute @booking.valid?
    # Check that object is invalid due to invalid date attribute.
    assert @booking.errors.key?(:date)
  end

  test "should belong to one space" do
    # Test belongs_to side of association (with Space) using .space method provided by ORM.
    assert @booking.space == @space
  end

  test "should belong to one vehicle" do
    # Test belongs_to side of association (with Vehicle) using .vehicle method provided by ORM.
    assert @booking.vehicle == @vehicle
  end

  test "should belong to one cost_type" do
    # Test belongs_to side of association (with CostType) using .cost_type method provided by ORM.
    assert @booking.cost_type == @cost_type
  end

  test "#with_date" do
    # Test that the number of bookings retrieved for a particular date increases by 1, when a new booking is made for that date.
    assert_difference('Booking.with_date(Date.today).length', 1) do
      @booking.save
    end
  end
end
