require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest

  # Test index action.
  test "should get index" do
    # Test RESTful route.
    get spaces_url
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'h1', 'Listing Spaces for: ' + Date.today.strftime('%d/%m/%Y')
  end

end
