require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select 'title', 'Car Park Space Bookings'
    assert_select 'h1', 'Home Page'
    assert_select 'p', 'Welcome to the home page!'
  end

end
