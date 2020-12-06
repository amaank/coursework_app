require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @vehicle = vehicles(:one)
    @user = users(:one)
    sign_in @user
  end

  # Test index action.
  test "should get index" do
    # Perform RESTful request.
    get vehicles_url

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @vehicles instance variable has been set.
    assert_not_nil assigns(:vehicles)

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'My Vehicles'
    assert_select 'p', 'An overview of the vehicles that you have registered with us'
    assert_select 'th', 'Registration Number'
    assert_select 'th', 'Make'
    assert_select 'th', 'Model'
    assert_select 'th', 'Colour'
    assert_select 'th', 'Options'
    assigns(:vehicles).each do |vehicle|
      assert_select 'td', "#{vehicle.registration_number}"
      assert_select 'td', "#{vehicle.make}"
      assert_select 'td', "#{vehicle.model}"
      assert_select 'td', "#{vehicle.colour}"
      assert_select 'a', "Show"
      assert_select 'a', "Update"
      assert_select 'a', "Un-register"
    end
    assert_select 'a', 'New Vehicle'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get vehicles_url
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test new action.
  test "should get new" do
    # Perform RESTful request.
    get new_vehicle_url

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @vehicle instance variable has been set.
    assert_not_nil assigns(:vehicle)

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'New Vehicle'
    assert_select 'p', 'Register a new vehicle with us'
    assert_select 'a', 'My Vehicles'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get new_vehicle_url
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test create action.
  test "should create vehicle" do
    # Test for an increase in the number of Vehicle objects, following create action.
    assert_difference('Vehicle.count') do
      # Perform RESTful request.
      post vehicles_url, params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: (@vehicle.registration_number)[0..3] + " ABC" } }
    end

    # Ensure that a @vehicle instance variable has been set.
    assert_not_nil assigns(:vehicle)

    # Ensure that the new object has been associated with a user.
    assert_not_nil assigns(:vehicle).user

    # Test for redirect after successful 'post' request.
    assert_redirected_to vehicle_url(Vehicle.last)

    # Test for appropriate flash notice following create action.
    assert_equal "#{I18n.t('vehicles.create.success')}", flash[:notice]

    # Ensure that a redirect occurs if no user is signed in.
    logout
    post vehicles_url, params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: (@vehicle.registration_number)[0..3] + " ABC" } }
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test show action.
  test "should show vehicle" do
    # Perform RESTful request.
    get vehicle_url(@vehicle)

    # Check that the request was performed successfully.
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_bookings_list', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', "Showing \"#{@vehicle.registration_number}\""
    assert_select 'h3', 'Details'
    assert_select 'p', "The details that you've provided for this vehicle"
    assert_select 'b', 'Registration Number:'
    assert_select 'p', "#{@vehicle.registration_number}"
    assert_select 'b', 'Make:'
    assert_select 'p', "#{@vehicle.make}"
    assert_select 'b', 'Model:'
    assert_select 'p', "#{@vehicle.model}"
    assert_select 'b', 'Colour:'
    assert_select 'p', "#{@vehicle.colour}"
    assert_select 'h3', 'Bookings'
    assert_select 'p', "The bookings that you've made for this vehicle"
    assert_select 'a', 'Update Vehicle'
    assert_select 'a', 'New Booking'
    assert_select 'a', 'My Vehicles'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get vehicle_url(@vehicle)
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test edit action.
  test "should get edit" do
    # Perform RESTful request.
    get edit_vehicle_url(@vehicle)

    # Check that the request was performed successfully.
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', "Update \"#{@vehicle.registration_number}\""
    assert_select 'p', 'Configure the details that you have provided to us for this vehicle'
    assert_select 'a', 'Show Vehicle'
    assert_select 'a', 'My Vehicles'

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get edit_vehicle_url(@vehicle)
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test update action.
  test "should update vehicle" do
    # Perform RESTful request.
    patch vehicle_url(@vehicle), params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: @vehicle.registration_number } }

    # Test for redirect after successful 'patch' request.
    assert_redirected_to vehicle_url(@vehicle)

    # Test for appropriate flash notice following update action.
    assert_equal "#{I18n.t('vehicles.update.success')}", flash[:notice]

    # Ensure that a redirect occurs if no user is signed in.
    logout
    patch vehicle_url(@vehicle), params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: @vehicle.registration_number } }
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test destroy action.
  test "should destroy vehicle" do
    # Test for a decrease in the number of Vehicle objects, following destroy action.
    assert_difference('Vehicle.count', -1) do
      # Perform RESTful request.
      delete vehicle_url(@vehicle)
    end

    # Test for redirect after successful 'delete' request.
    assert_redirected_to vehicles_url

    # Test for appropriate flash notice following destroy action.
    assert_equal "#{I18n.t('vehicles.destroy.success')}", flash[:notice]
  end

  # Test AJAX request for destroy action.
  test "should send AJAX request on destroy" do
    # Test for a decrease in the number of Vehicle objects, following destroy action.
    assert_difference('Vehicle.count', -1) do
      # Perform RESTful request.
      delete vehicle_url(@vehicle), xhr: true
    end

    # Check that the response includes a necessary message for the user.
    assert @response.body.include?("#{I18n.t('vehicles.destroy.success')}")

    # Check that JavaScript is returned in response to the action.
    assert_equal "text/javascript", @response.media_type

    # Test for appropriate flash notice following destroy action.
    assert_equal "#{I18n.t('vehicles.destroy.success')}", flash.now[:notice]
  end

  test "should redirect instead of destroy if no user signed in" do
    logout

    # Ensure that no change in the number of Vehicle objects occurs (no object is destroyed).
    assert_no_difference 'Vehicle.count' do
      # Perform RESTful request.
      delete vehicle_url(@vehicle)
    end

    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end
end
