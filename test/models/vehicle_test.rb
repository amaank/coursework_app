require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    @vehicle = Vehicle.new(registration_number: "XX00 XXX", make: "Ford", model: "Focus", colour: "Blue")
  end

  test "valid vehicle" do
    assert @vehicle.valid?
  end

  test "invalid if registration number not correctly formatted" do
    @vehicle.registration_number += "X"
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:registration_number)
  end

  test "invalid without registration number" do
    @vehicle.registration_number = nil
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:registration_number)
  end

  test "invalid without make" do
    @vehicle.make = nil
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:make)
  end

  test "invalid without model" do
    @vehicle.model = nil
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:model)
  end

  test "invalid if make length less than 2" do
    @vehicle.make = "a"
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:make)
  end

  test "invalid if model length less than 2" do
    @vehicle.model = "a"
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:model)
  end

  test "invalid if duplicate registration number, case-insensitive" do
    @vehicle.save
    new_vehicle = Vehicle.new(registration_number: @vehicle.registration_number.swapcase, make: "Audi", model: "R8", colour: "White")
    refute new_vehicle.valid?
    assert new_vehicle.errors.key?(:registration_number)
  end

  test "should be able to have bookings" do
    assert_difference('@vehicle.bookings.size', 2) do
      @vehicle.save
      booking_one = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: 1010-10-10)
      booking_one.save
      booking_two = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: 1005-10-10)
      booking_two.save
    end
  end

  test "when destroyed, should have bookings destroyed" do
    @vehicle.save
    booking = Booking.new(space_id: Space.first.id, vehicle_id: @vehicle.id, cost_type_id: CostType.first.id, date: 1010-10-10)
    booking.save
    assert @vehicle.destroy
    assert_raise(ActiveRecord::RecordNotFound) { booking.reload }
  end
end
