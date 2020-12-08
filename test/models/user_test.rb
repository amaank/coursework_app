require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # Create a valid 'User' object.
    @user = User.new
    @user.email = 'bob@example.com'
    @user.password = '12345678'
  end

  test 'should save valid user' do
    @user.save
    assert @user.valid?
  end

  test 'should not save invalid user' do
    # Remove all attribute values assigned to the user object.
    @user.email = nil
    @user.password = nil
    @user.save
    refute @user.valid?
  end

  test "should be able to have many vehicles" do
    # Test that the following code causes the number of associated vehicle objects to increase by 2.
    assert_difference('@user.vehicles.size', 2) do
      # Save object to database.
      @user.save
      # Create new vehicle object which references this user object.
      vehicle_one = vehicles(:one)
      vehicle_one.user = @user
      # Save this to the database.
      vehicle_one.save
      # Create another vehicle object which also references the user object.
      vehicle_two = vehicles(:two)
      vehicle_two.user = @user
      # Also save this to the database.
      vehicle_two.save
    end
  end
end
