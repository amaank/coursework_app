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
    @vehicle.registration_number = Vehicle.first.registration_number.swapcase
    refute @vehicle.valid?
    assert @vehicle.errors.key?(:registration_number)
  end
end
