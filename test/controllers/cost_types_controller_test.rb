require 'test_helper'

class CostTypesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  # Test index action.
  test "should get index" do
    # Perform RESTful request.
    get pricing_url

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @cost_types instance variable has been set.
    assert_not_nil assigns(:cost_types)

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Pricing'
    assert_select 'p', 'An overview of the types of parking service that we provide'
    assert_select 'th', 'Name'
    assert_select 'th', 'Price'
    assert_select 'th', 'Description'
    CostType.all.each do |cost_type|
      assert_select 'td', "#{cost_type.name}"
      assert_select 'td', "£#{cost_type.price}"
      assert_select 'td', "#{cost_type.description}"
    end

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get pricing_url
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

end
