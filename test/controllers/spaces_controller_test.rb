require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  # Test index action when no date supplied.
  test "should get index for today, if no date provided" do
    # Perform RESTful request without supplying any parameters (no date).
    get spaces_url

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @spaces instance variable has been set.
    assert_not_nil assigns(:spaces)

    # Ensure that a @chosen_date instance variable has been set equal to today's date.
    assert_equal assigns(:chosen_date), Date.today

    # Test inclusion of necessary view files.
    assert_template layout: 'application'
    assert_template partial: '_footer', count: 1
    assert_template partial: '_header', count: 1

    # Test basic view content.
    assert_select 'title', 'ParkMyCar'
    assert_select 'h1', 'Spaces'
    assert_select 'p', 'An overview of the spaces that are available for a given date'
    assert_select 'h3', 'Pick a Date'
    assert_select 'label', 'Date:'
    assert_select 'input[type=date]'
    assert_select 'input[type=submit][value="Search"]'
    assert_select 'h3', 'Legend'
    assert_select 'td', 'Available'
    assert_select 'td', 'Unavailable'

    chosen_date = assigns(:chosen_date)
    assert_select 'h2', "Listing Spaces for: #{chosen_date.strftime('%d/%m/%Y')}"

    spaces = assigns(:spaces)
    spaces.distinct.pluck(:floor).each do |floor|
      assert_select 'h3', "Floor #{floor}"
    end
    spaces.distinct.pluck(:column).each do |column|
      assert_select 'td', "Column #{column}"
    end
    spaces.distinct.pluck(:row).each do |row|
      assert_select 'td', "Row #{row}"
    end

    # Ensure that a redirect occurs if no user is signed in.
    logout
    get spaces_url
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  # Test index action when invalid date supplied.
  test "should get index for today, if date in past (invalid) provided" do
    # Perform RESTful request with date supplied within the parameters.
    # Provide a date which is in the past (invalid).
    get spaces_url, params: {date: Date.yesterday}

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @spaces instance variable has been set.
    assert_not_nil assigns(:spaces)

    # Ensure that a @chosen_date instance variable has been set equal to today's date.
    assert_equal assigns(:chosen_date), Date.today

    # Test for appropriate flash alert to tell the user that the date was invalid.
    assert_equal "#{I18n.t('spaces.index.invalid_date.too_early')}", flash.now[:alert]
  end

  # Test index action when invalid date supplied.
  test "should get index for today, if date more than 7 days in future (invalid) provided" do
    # Perform RESTful request with date supplied within the parameters.
    # Provide a date which is more than 7 days from today (invalid).
    get spaces_url, params: {date: Date.today + 8.days}

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @spaces instance variable has been set.
    assert_not_nil assigns(:spaces)

    # Ensure that a @chosen_date instance variable has been set equal to today's date.
    assert_equal assigns(:chosen_date), Date.today

    # Test for appropriate flash alert to tell the user that the date was invalid.
    assert_equal "#{I18n.t('spaces.index.invalid_date.too_late')}", flash.now[:alert]
  end

  # Test index action when invalid date supplied.
  test "should get index for today, if date provided cannot be parsed" do
    # Perform RESTful request with date supplied within the parameters.
    # Provide a value which is not a date, for the date parameter.
    get spaces_url, params: {date: "not a date"}

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @spaces instance variable has been set.
    assert_not_nil assigns(:spaces)

    # Ensure that a @chosen_date instance variable has been set equal to today's date.
    assert_equal assigns(:chosen_date), Date.today

    # Test for appropriate flash alert to tell the user that the date was invalid.
    assert_equal "#{I18n.t('spaces.index.invalid_date.default')}", flash.now[:alert]
  end

  # Test index action when valid date supplied.
  test "should get index for chosen date, if valid date provided" do
    # Perform RESTful request with date supplied within the parameters.
    # Provide a valid date.
    valid_date = Date.today + 7.days
    get spaces_url, params: {date: valid_date}

    # Check that the request was performed successfully.
    assert_response :success

    # Ensure that a @spaces instance variable has been set.
    assert_not_nil assigns(:spaces)

    # Ensure that a @chosen_date instance variable has been set equal to the chosen date.
    assert_equal assigns(:chosen_date), valid_date
  end

end
