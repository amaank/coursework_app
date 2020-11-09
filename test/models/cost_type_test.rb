require 'test_helper'

class CostTypeTest < ActiveSupport::TestCase
  def setup
    @used_name = CostType.first.name
    @cost_type = CostType.new(name: @used_name + "new", price: 1.0, description: "description")
  end

  test "valid cost_type" do
    assert @cost_type.valid?
  end

  test "invalid without name" do
    @cost_type.name = nil
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:name)
  end

  test "invalid without price" do
    @cost_type.price = nil
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:price)
  end

  test "invalid without description" do
    @cost_type.description = nil
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:description)
  end

  test "invalid if name length less than 2" do
    @cost_type.name = "a"
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:name)
  end

  test "invalid if description length less than 2" do
    @cost_type.description = "a"
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:description)
  end

  test "invalid if duplicate name, case-insensitive" do
    @cost_type.name = @used_name.swapcase
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:name)
  end

  test "invalid if price less than 0" do
    @cost_type.price = -1.0
    refute @cost_type.valid?
    assert @cost_type.errors.key?(:price)
  end

  test "should be able to have many bookings" do
    assert_difference('@cost_type.bookings.size', 2) do
      @cost_type.save
      vehicle = Vehicle.new(registration_number: "XX00 XZZ", make: "Ford", model: "Focus", colour: "Blue")
      vehicle.save
      booking_one = Booking.new(space_id: Space.first.id, vehicle_id: vehicle.id, cost_type_id: @cost_type.id, date: 1010-10-10)
      booking_one.save
      booking_two = Booking.new(space_id: Space.first.id, vehicle_id: vehicle.id, cost_type_id: @cost_type.id, date: 1005-10-10)
      booking_two.save
    end
  end
end
