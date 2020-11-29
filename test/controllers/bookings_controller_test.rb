require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @booking = bookings(:one)
    @vehicle = vehicles(:one)
    @user = users(:one)
    sign_in @user
  end

  # Test new action.
  test "should get new" do
    # Test RESTful route.
    get new_vehicle_booking_path(@vehicle)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', "New Booking for #{@vehicle.registration_number}"
    assert_select 'a', 'Back'

  end

  # Test create action.
  test "should create booking" do
    assert_difference('Booking.count') do
      # Test RESTful route.
      post vehicle_bookings_path(@vehicle), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    end
    # Test for redirect after successful 'post' request.
    assert_redirected_to vehicle_path(@vehicle)
  end

  # Test edit action.
  test "should get edit" do
    # Test RESTful route.
    get edit_vehicle_booking_path(@vehicle, @booking)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', 'Update Booking'
    assert_select 'a', 'Back'
  end

  # Test update action.
  test "should update booking" do
    # Test RESTful route.
    patch vehicle_booking_path(@vehicle, @booking), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    # Test for redirect after successful 'patch' request.
    assert_redirected_to vehicle_path(@vehicle)
  end

  # Test destroy action.
  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      # Test RESTful route.
      delete vehicle_booking_path(@vehicle, @booking)
    end
    # Test for redirect after successful 'delete' request.
    assert_redirected_to vehicle_path(@vehicle)
  end
end
