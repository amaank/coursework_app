require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  # Test for email being returned by mailer.
  test "should return contact email" do
    mail = ContactMailer.contact_email("amaan@me.com",
      "Amaan Khalid", "1234567890", @message = "Hello")
    # Test content of returned email.
    assert_equal ['info@carparkspacebooker.com'], mail.to
    assert_equal ['info@carparkspacebooker.com'], mail.from
  end

end
