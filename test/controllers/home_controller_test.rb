require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  # Test home action.
  test "should get home" do
    # Perform RESTful request.
    get root_url

    # Check that the request was performed successfully.
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Home'
    assert_select 'p', 'Welcome to ParkMyCar!'
    assert_select 'h1', 'Unsure where to go first?'
    assert_select 'p', 'Click a name to learn more about the corresponding page'
    assert_select 'button', 'Home'
    assert_select 'button', 'Contact'
    assert_select 'button', 'My Vehicles'
    assert_select 'button', 'Pricing'
    assert_select 'button', 'Spaces'
    assert_select 'p', 'Note: you must be signed in to visit this page.', count: 3
    assert_select 'p', 'To visit this page, you can either use the menu at the top, or click the following link:', count: 4
    assert_select 'a', 'Visit Page', count: 4
    assert_select 'h1', 'Welcome!'
    assert_select 'h1', "How to Get Started"
    assert_select 'h5', "1. Create an account or sign in to an existing account"
    assert_select 'a', "Create an account"
    assert_select 'a', "Sign in to an existing account"
    assert_select 'h5', "2. Register a vehicle"
    assert_select 'a', "Visit 'My Vehicles'"
    assert_select 'h5', "3. Check which choices are available to you"
    assert_select 'a', "Review pricing for the various services we offer"
    assert_select 'a', "See which parking spaces are available on your chosen date"
    assert_select 'h5', "4. Make a booking"
  end

  # Test contact action.
  test "should get contact" do
    # Perform RESTful request.
    get contact_url

    # Check that the request was performed successfully.
    assert_response :success

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', "We'd love to hear your feedback!"
    assert_select 'h3', 'Contact Form'
    assert_select 'p', 'Fill in the following form to let us know what you need!'
    assert_select 'label', 'Name:'
    assert_select 'label', 'Email:'
    assert_select 'label', 'Telephone:'
    assert_select 'label', 'Message:'
    assert_select 'input[type=text]', count: 2
    assert_select 'input[type=email]', count: 1
    assert_select 'input[type=tel]', count: 1
    assert_select 'input[type=submit][value="Contact Us"]', count: 1
  end

  # Test request_contact action when no email supplied.
  test "should post request contact but no email" do
    # Perform RESTful request without supplying any parameters (no email).
    post request_contact_url

    # Ensure that the user is redirected.
    assert_response :redirect

    # Test for appropriate flash alert following action.
    assert_equal "#{I18n.t('home.request_contact.no_email')}", flash[:alert]

    # Ensure that a notice isn't shown to the user, as this would indicate success.
    assert_nil flash[:notice]
  end

  # Test request_contact action when an email is provided.
  test "should post request contact" do
    # Perform RESTful request with email supplied within the parameters.
    post request_contact_url, params:
      {name: "Amaan", email: "amaan@me.com",
      telephone: "1234567890", message: "Hello"}

    # Ensure that the user is redirected.
    assert_response :redirect

    # Test for appropriate flash notice following action.
    assert_equal "#{I18n.t('home.request_contact.email_sent')}", flash[:notice]

    # Ensure that an alert isn't shown to the user, as this would indicate failure.
    assert_nil flash[:alert]
  end

end
