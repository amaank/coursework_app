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
    assert @space.errors.key?(:floor)
  end

  test "invalid without row" do
    @space.row = nil
    refute @space.valid?
    assert @space.errors.key?(:row)
  end

  test "invalid without column" do
    @space.column = nil
    refute @space.valid?
    assert @space.errors.key?(:column)
  end

  test "invalid if duplicate floor, row and column combination" do
    used = Space.first
    assert used.valid?
    @space.floor = used.floor
    @space.row = used.row
    @space.column = used.column
    refute @space.valid?
    # Uniqueness validation is on the floor attribute, limited by row and column
    # Hence errors will be produced for the floor attribute only, in this case
    assert @space.errors.key?(:floor)
  end
end
