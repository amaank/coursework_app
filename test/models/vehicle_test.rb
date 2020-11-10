require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    # Create a valid 'Vehicle' object.
    @vehicle = vehicles(:one)
    @vehicle.registration_number = "XX00 XXX"
  end

  test "valid vehicle" do
    assert @vehicle.valid?
  end

  test "invalid if registration number not correctly formatted" do
    # Append string to correctly formatted registration_number to violate the format requirement.
    @vehicle.registration_number += "X"
    refute @vehicle.valid?
    # Check that object is invalid due to invalid value for registration_number attribute.
    assert @vehicle.errors.key?(:registration_number)
  end

  test "invalid without registration number" do
    # Remove the value of the registration_number attribute.
    @vehicle.registration_number = nil
    refute @vehicle.valid?
    # Check that the object is invalid due to missing value for registration_number attribute.
    assert @vehicle.errors.key?(:registration_number)
  end

  test "invalid without make" do
    # Remove the value of the make attribute.
    @vehicle.make = nil
    refute @vehicle.valid?
    # Check that object is invalid due to missing value for make attribute.
    assert @vehicle.errors.key?(:make)
  end

  test "invalid without model" do
    # Remove value of the model attribute.
    @vehicle.model = nil
    refute @vehicle.valid?
    # Check that object is invalid due to missing value for model attribute.
    assert @vehicle.errors.key?(:model)
  end

  test "invalid if make length less than 2" do
    # Set value of make attribute to a string with length less than 2.
    @vehicle.make = "a"
    refute @vehicle.valid?
    # Check that object is invalid due to invalid value for make attribute.
    assert @vehicle.errors.key?(:make)
  end

  test "invalid if model length less than 2" do
    # Set value of model attribute to a string with length less than 2.
    @vehicle.model = "a"
    refute @vehicle.valid?
    # Check that object is invalid due to invalid value for model attribute.
    assert @vehicle.errors.key?(:model)
  end

  test "invalid if duplicate registration number, case-insensitive" do
    # Save vehicle object to database.
    @vehicle.save
    # Create a new vehicle object with the same registration_number value as the object we just saved.
    # Swap the case before assigning the registration_number value, to test that case is ignored by the validation.
    new_vehicle = vehicles(:two)
    new_vehicle.registration_number = @vehicle.registration_number.swapcase
    refute new_vehicle.valid?
    # Check that object is invalid due to invalid (duplicate) value for registration_number attribute.
    assert new_vehicle.errors.key?(:registration_number)
  end

  test "should be able to have many bookings" do
    # Test that the following code causes the number of associated booking objects to increase by 2.
    assert_difference('@vehicle.bookings.size', 2) do
      # Save object to database.
      @vehicle.save
      # Create new booking object which references this vehicle object.
      booking_one = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: Date.today)
      # Save this to the database.
      booking_one.save
      # Create another booking object which also references the vehicle object.
      booking_two = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: Date.tomorrow)
      # Also save this to the database.
      booking_two.save
    end
  end

  test "when destroyed, should have bookings destroyed" do
    # Save vehicle to the database so we can test destroying it.
    @vehicle.save
    # Create a booking object which references this vehicle object.
    booking = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: Date.today)
    # Save to database.
    booking.save
    # Destroy the vehicle object (record) and check that it was successful.
    assert @vehicle.destroy
    # Reload attributes of dependent booking object from corresponding record in database.
    # This record should have been removed, so check for appropriate exception being raised.
    assert_raise(ActiveRecord::RecordNotFound) { booking.reload }
  end
end
