require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = bookings(:one)
  end

  # Test index action.
  test "should get index" do
    # Test RESTful route.
    get bookings_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'h1', 'Listing Bookings'
    assert_select 'th', 'Space'
    assert_select 'th', 'Vehicle'
    assert_select 'th', 'Cost Type'
    assert_select 'th', 'Date'
    assert_select 'a', 'New Booking'
  end

  # Test new action.
  test "should get new" do
    # Test RESTful route.
    get new_booking_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', 'New Booking'
    assert_select 'a', 'Back'

  end

  # Test create action.
  test "should create booking" do
    assert_difference('Booking.count') do
      # Test RESTful route.
      post bookings_url, params: { booking: { cost_type_id: @booking.cost_type_id, date: @booking.date, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    end
    # Test for redirect after successful 'post' request.
    assert_redirected_to booking_url(Booking.last)
  end

  # Test show action.
  test "should show booking" do
    # Test RESTful route.
    get booking_url(@booking)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'a', 'Update'
    assert_select 'a', 'Back'
  end

  # Test edit action.
  test "should get edit" do
    # Test RESTful route.
    get edit_booking_url(@booking)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', 'Editing Booking'
    assert_select 'a', 'Show'
    assert_select 'a', 'Back'
  end

  # Test update action.
  test "should update booking" do
    # Test RESTful route.
    patch booking_url(@booking), params: { booking: { cost_type_id: @booking.cost_type_id, date: @booking.date, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    # Test for redirect after successful 'patch' request.
    assert_redirected_to booking_url(@booking)
  end

  # Test destroy action.
  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      # Test RESTful route.
      delete booking_url(@booking)
    end
    # Test for redirect after successful 'delete' request.
    assert_redirected_to bookings_url
  end
end
