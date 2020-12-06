require 'test_helper'

class CostTypesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  # Test index action.
  test "should get index" do
    # Test RESTful route.
    get pricing_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Pricing'
    assert_select 'th', 'Name'
    assert_select 'th', 'Price'
    assert_select 'th', 'Description'
  end

end
