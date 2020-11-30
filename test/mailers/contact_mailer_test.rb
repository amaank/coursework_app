require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  # Test for email being returned by mailer.
  test "should return contact email" do
    mail = ContactMailer.contact_email("amaan@me.com",
      "Amaan Khalid", "1234567890", @message = I18n.t('mailer.message'))
    # Test content of returned email.
    assert_equal ['info@parkmycars.com'], mail.to
    assert_equal ['info@parkmycars.com'], mail.from
    assert_equal ['amaan@me.com'], mail.cc
  end

end
