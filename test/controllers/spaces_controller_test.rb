require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = spaces(:one)
  end

  # Test index action.
  test "should get index" do
    # Test restful route.
    get spaces_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'h1', 'Listing spaces'
    assert_select 'th', 'Floor'
    assert_select 'th', 'Row'
    assert_select 'th', 'Column'
    # uncomment once you add the space records: assert_select 'td', 'Show'
  end

  # UNCOMMENT THE FOLLOWING TEST, ONCE YOU'VE ADDED SPACE RECORDS TO THE DATABASE
  # AS THE 'SHOW' METHOD CANNOT BE TESTED WITHOUT RECORDS TO SHOW
  # Test show action.
  test "should show space" do
    # Test restful route.
    # get spaces_url(@space)
    # assert_response :success

    # Test inclusion of necessary view files.
    # ssert_template layout: 'application'
    # assert_template partial: '_footer', count: 1
    # assert_template partial: '_header', count: 1

    # Test basic view content.
    # assert_select 'b', 'Floor'
    # assert_select 'b', 'Row'
    # assert_select 'b', 'Column'
    # assert_select 'a', 'Back'
  end

end
