require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  test "valid space" do
    unused = Space.all.count + 1
    space = Space.new(floor: unused, row: unused, column: unused)
    assert space.valid?
  end

  test "invalid without floor" do
    space = Space.new(row: 1, column: 1)
    refute space.valid?
    assert_not_nil space.errors[:floor]
  end

  test "invalid without row" do
    space = Space.new(floor: 1, column: 1)
    refute space.valid?
    assert_not_nil space.errors[:row]
  end

  test "invalid without column" do
    space = Space.new(floor: 1, row: 1)
    refute space.valid?
    assert_not_nil space.errors[:column]
  end

  test "invalid if duplicate floor, row and column combination" do
    used = Space.first
    assert used.valid?
    space = Space.new(floor: used.floor, row: used.row, column: used.column)
    refute space.valid?
    assert_not_nil space.errors[:index_spaces_on_floor_and_row_and_column]
  end
end
