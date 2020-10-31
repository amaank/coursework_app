require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  test "should return contact email" do
    mail = ContactMailer.contact_email("amaan@me.com",
      "Amaan Khalid", "1234567890", @message = "Hello")
    assert_equal ['info@carparkspacebooker.com'], mail.to
    assert_equal ['info@carparkspacebooker.com'], mail.from
  end

end
