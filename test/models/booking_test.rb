require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    space = Space.first
    vehicle = Vehicle.new(registration_number: "QR00 EFG", make: "Subaru", model: "Impreza", colour: "Blue")
    vehicle.save
    cost_type = CostType.first
    @booking = Booking.new(space_id: space.id, vehicle_id: vehicle.id, cost_type_id: cost_type.id, date: 1111-11-11)
  end

  test "valid booking" do
    assert @booking.valid?
  end

  test "invalid if referenced space is invalid" do
    @booking.space_id = Space.last.id + 1
    refute @booking.valid?
    assert @booking.errors.key?(:space)
  end

  test "invalid if referenced vehicle is invalid" do
    @booking.vehicle_id = Vehicle.last.id + 1
    refute @booking.valid?
    assert @booking.errors.key?(:vehicle)
  end

  test "invalid if referenced cost_type is invalid" do
    @booking.cost_type_id = CostType.last.id + 1
    refute @booking.valid?
    assert @booking.errors.key?(:cost_type)
  end

  test "invalid without space_id" do
    @booking.space_id = nil
    refute @booking.valid?
    assert @booking.errors.key?(:space_id)
  end

  test "invalid without vehicle_id" do
    @booking.vehicle_id = nil
    refute @booking.valid?
    assert @booking.errors.key?(:vehicle_id)
  end

  test "invalid without cost_type_id" do
    @booking.cost_type_id = nil
    refute @booking.valid?
    assert @booking.errors.key?(:cost_type_id)
  end

  test "invalid without date" do
    @booking.date = nil
    refute @booking.valid?
    assert @booking.errors.key?(:date)
  end

  test "invalid if duplicate space_id and date combination" do
    @booking.save
    new_vehicle = Vehicle.new(registration_number: "XW11 XYZ", make: "Bugatti", model: "Veyron", colour: "Red")
    new_vehicle.save
    new_booking = Booking.new(space_id: @booking.space_id, vehicle_id: new_vehicle.id, cost_type_id: CostType.second.id, date: @booking.date)
    refute new_booking.valid?
    assert new_booking.errors.key?(:space_id)
  end

  test "invalid if duplicate vehicle_id and date combination" do
    @booking.save
    new_booking = Booking.new(space_id: Space.second.id, vehicle_id: @booking.vehicle_id, cost_type_id: CostType.second.id, date: @booking.date)
    refute new_booking.valid?
    assert new_booking.errors.key?(:vehicle_id)
  end
end
