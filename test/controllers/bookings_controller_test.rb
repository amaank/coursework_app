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
    # Perform RESTful request.
    get new_vehicle_booking_path(@vehicle)

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @booking instance variable has been set.
    assert_not_nil assigns(:booking)

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', "New Booking for \"#{@vehicle.registration_number}\""
    assert_select 'p', 'Make a new booking for this vehicle'
    assert_select 'a', 'Show Vehicle'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get new_vehicle_booking_path(@vehicle)
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test create action.
  test "should create booking" do
    # Test for an increase in the number of Booking objects, following create action.
    assert_difference('Booking.count') do
      # Perform RESTful request.
      post vehicle_bookings_path(@vehicle), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    end

    # Ensure that a @booking instance variable has been set.
    assert_not_nil assigns(:booking)

    # Test for redirect after successful 'post' request.
    assert_redirected_to vehicle_path(@vehicle)

    # Test for appropriate flash notice following create action.
    assert_equal "#{I18n.t('bookings.create.success')}", flash[:notice]

    # Ensure that a redirect occurs if no user is signed in.
    logout
    post vehicle_bookings_path(@vehicle), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test edit action.
  test "should get edit" do
    # Perform RESTful request.
    get edit_vehicle_booking_path(@vehicle, @booking)

    # Check that the request was performed successfully.
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', "Update Booking for \"#{@vehicle.registration_number}\""
    assert_select 'p', 'Update a booking for this vehicle'
    assert_select 'a', 'Show Vehicle'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get edit_vehicle_booking_path(@vehicle, @booking)
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test update action.
  test "should update booking" do
    # Perform RESTful request.
    patch vehicle_booking_path(@vehicle, @booking), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }

    # Test for redirect after successful 'patch' request.
    assert_redirected_to vehicle_path(@vehicle)

    # Test for appropriate flash notice following update action.
    assert_equal "#{I18n.t('bookings.update.success')}", flash[:notice]

    # Ensure that a redirect occurs if no user is signed in.
    logout
    patch vehicle_booking_path(@vehicle, @booking), params: { booking: { cost_type_id: @booking.cost_type_id, date: Date.today, space_id: @booking.space_id, vehicle_id: @booking.vehicle_id } }
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test destroy action.
  test "should destroy booking" do
    # Test for a decrease in the number of Booking objects, following destroy action.
    assert_difference('Booking.count', -1) do
      # Perform RESTful request.
      delete vehicle_booking_path(@vehicle, @booking)
    end

    # Test for redirect after successful 'delete' request.
    assert_redirected_to vehicle_path(@vehicle)

    # Test for appropriate flash notice following destroy action.
    assert_equal "#{I18n.t('bookings.destroy.success')}", flash[:notice]
  end

  # Test AJAX request for destroy action.
  test "should send AJAX request on destroy" do
    # Test for a decrease in the number of Booking objects, following destroy action.
    assert_difference('Booking.count', -1) do
      # Perform RESTful request.
      delete vehicle_booking_path(@vehicle, @booking), xhr: true
    end

    # Check that the response includes a necessary message for the user.
    assert @response.body.include?("#{I18n.t('bookings.destroy.success')}")

    # Check that JavaScript is returned in response to the action.
    assert_equal "text/javascript", @response.media_type

    # Test for appropriate flash notice following destroy action.
    assert_equal "#{I18n.t('bookings.destroy.success')}", flash.now[:notice]
  end

  test "should redirect instead of destroy if no user signed in" do
    logout

    # Ensure that no change in the number of Booking objects occurs (no object is destroyed).
    assert_no_difference 'Booking.count' do
      # Perform RESTful request.
      delete vehicle_booking_path(@vehicle, @booking)
    end

    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

end
