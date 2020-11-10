require 'test_helper'

class CostTypeTest < ActiveSupport::TestCase
  def setup
    # Make use of an existing record in 'cost_types' that should always be present.
    @used_name = CostType.first.name
    # Create a valid 'CostType' object.
    @cost_type = cost_types(:one)
    @cost_type.name += "X"
  end

  test "valid cost_type" do
    assert @cost_type.valid?
  end

  test "invalid without name" do
    # Remove the value of the name attribute.
    @cost_type.name = nil
    refute @cost_type.valid?
    # Check that the object is invalid due to missing value for name attribute.
    assert @cost_type.errors.key?(:name)
  end

  test "invalid without price" do
    # Remove the value of the price attribute.
    @cost_type.price = nil
    refute @cost_type.valid?
    # Check that the object is invalid due to missing value for price attribute.
    assert @cost_type.errors.key?(:price)
  end

  test "invalid without description" do
    # Remove the value of the description attribute.
    @cost_type.description = nil
    refute @cost_type.valid?
    # Check that the object is invalid due to missing value for description attribute.
    assert @cost_type.errors.key?(:description)
  end

  test "invalid if name length less than 2" do
    # Set value of name attribute to a string with length less than 2.
    @cost_type.name = "a"
    refute @cost_type.valid?
    # Check that the object is invalid due to invalid value for name attribute.
    assert @cost_type.errors.key?(:name)
  end

  test "invalid if description length less than 2" do
    # Set value of description attribute to a string with length less than 2.
    @cost_type.description = "a"
    refute @cost_type.valid?
    # Check that the object is invalid due to invalid value for description attribute.
    assert @cost_type.errors.key?(:description)
  end

  test "invalid if duplicate name, case-insensitive" do
    # Set name attribute of the object to be the same as an existing object.
    # Swap the case before assigning the value, to test that case is ignored at the same time.
    @cost_type.name = @used_name.swapcase
    refute @cost_type.valid?
    # Check that the object is invalid due to invalid (duplicate) value for name attribute.
    assert @cost_type.errors.key?(:name)
  end

  test "invalid if price less than 0" do
    # Set value of price attribute to be less than 0.
    @cost_type.price *= -1
    refute @cost_type.valid?
    # Check that object is invalid due to invalid value for price attribute.
    assert @cost_type.errors.key?(:price)
  end

  test "should be able to have many bookings" do
    # Test that the following code causes the number of associated booking objects to increase by 2.
    assert_difference('@cost_type.bookings.size', 2) do
      # Save object to database.
      @cost_type.save
      # Create new vehicle object.
      vehicle = vehicles(:one)
      # Save object to database.
      vehicle.save
      # Create new booking object which references our cost_type object.
      booking_one = Booking.new(space_id: Space.first.id, vehicle_id: vehicle.id, cost_type_id: @cost_type.id, date: Date.today)
      # Save this to the database.
      booking_one.save
      # Create another booking object which also references our cost_type object.
      booking_two = Booking.new(space_id: Space.first.id, vehicle_id: vehicle.id, cost_type_id: @cost_type.id, date: Date.tomorrow)
      # And also save to the database.
      booking_two.save
    end
  end
end
