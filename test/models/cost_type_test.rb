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
    assert_not_nil @cost_type.errors[:name]
  end

  test "invalid without price" do
    @cost_type.price = nil
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:price]
  end

  test "invalid without description" do
    @cost_type.description = nil
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:description]
  end

  test "invalid if name length less than 2" do
    @cost_type.name = "a"
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:name]
  end

  test "invalid if description length less than 2" do
    @cost_type.description = "a"
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:description]
  end

  test "invalid if duplicate name, case-insensitive" do
    @cost_type.name = @used_name.swapcase
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:name]
  end

  test "invalid if price less than 0" do
    @cost_type.price = -1.0
    refute @cost_type.valid?
    assert_not_nil @cost_type.errors[:price]
  end
end
