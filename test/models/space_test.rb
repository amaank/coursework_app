require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  def setup
    unused = Space.all.count + 1
    @space = Space.new(floor: unused, row: unused, column: unused)
  end

  test "valid space" do
    assert @space.valid?
  end

  test "invalid without floor" do
    @space.floor = nil
    refute @space.valid?
    assert_not_nil @space.errors[:floor]
  end

  test "invalid without row" do
    @space.row = nil
    refute @space.valid?
    assert_not_nil @space.errors[:row]
  end

  test "invalid without column" do
    @space.column = nil
    refute @space.valid?
    assert_not_nil @space.errors[:column]
  end

  test "invalid if duplicate floor, row and column combination" do
    used = Space.first
    assert used.valid?
    @space.floor = used.floor
    @space.row = used.row
    @space.column = used.column
    refute @space.valid?
    assert_not_nil @space.errors[:index_spaces_on_floor_and_row_and_column]
  end
end
