require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success


    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1


    assert_select 'title', 'Car Park Space Bookings'
    assert_select 'h1', 'Home Page'
    assert_select 'p', 'Welcome to the home page!'
  end

  test "should get contact" do
    get contact_url
    assert_response :success


    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1


    assert_select 'title', 'Car Park Space Bookings'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', 'Complete the following form to get in touch with us.'
  end

end
