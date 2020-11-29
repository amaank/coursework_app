require 'test_helper'

class UserFlowsTest < Capybara::Rails::TestCase

  test "sign up, log out and log in" do
    email = "amaan@example.com"
    password = "12345678"

    # Sign up.
    visit root_path
    click_link_or_button("Sign Up")
    fill_in "Email:", with: email
    fill_in "Password:", with: password
    fill_in "Password confirmation:", with: password
    click_link_or_button("Sign up")
    assert page.has_content?("Welcome! You have signed up successfully.")

    # Log out.
    click_link_or_button("Logout")
    assert page.has_content?("Signed out successfully.")

    # Log in.
    click_link_or_button("Login")
    fill_in "Email:", with: email
    fill_in "Password:", with: password
    click_link_or_button("Log in")
    assert page.has_content?("Signed in successfully.")
  end

end
