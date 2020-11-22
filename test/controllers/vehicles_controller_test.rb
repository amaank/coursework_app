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
    # Test RESTful route.
    get vehicles_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'h1', 'Listing Vehicles'
    assert_select 'th', 'Registration Number'
    assert_select 'th', 'Make'
    assert_select 'th', 'Model'
    assert_select 'th', 'Colour'
    assert_select 'a', 'New Vehicle'
  end

  # Test new action.
  test "should get new" do
    # Test RESTful route.
    get new_vehicle_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', 'New Vehicle'
    assert_select 'a', 'Back'
  end

  # Test create action.
  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      # Test RESTful route.
      post vehicles_url, params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: (@vehicle.registration_number)[0..3] + " ABC" } }
    end

    # Test for redirect after successful 'post' request.
    assert_redirected_to vehicle_url(Vehicle.last)
  end

  # Test show action.
  test "should show vehicle" do
    # Test RESTful route.
    get vehicle_url(@vehicle)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_bookings_list', count: 1

    # Test basic view content.
    assert_select 'a', 'Update'
    assert_select 'a', 'Back'
    assert_select 'a', 'Add Booking'
  end

  # Test edit action.
  test "should get edit" do
    # Test RESTful route.
    get edit_vehicle_url(@vehicle)
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1
    assert_template partial: '_form', count: 1

    # Test basic view content.
    assert_select 'h1', 'Editing Vehicle'
    assert_select 'a', 'Show'
    assert_select 'a', 'Back'
  end

  # Test update action.
  test "should update vehicle" do
    # Test RESTful route.
    patch vehicle_url(@vehicle), params: { vehicle: { colour: @vehicle.colour, make: @vehicle.make, model: @vehicle.model, registration_number: @vehicle.registration_number } }
    # Test for redirect after successful 'patch' request.
    assert_redirected_to vehicle_url(@vehicle)
  end

  # Test destroy action.
  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      # Test RESTful route.
      delete vehicle_url(@vehicle)
    end
    # Test for redirect after successful 'delete' request.
    assert_redirected_to vehicles_url
  end
end
