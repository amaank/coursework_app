# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Define a preview (test) for mailer view.
  def contact_email
    ContactMailer.contact_email("amaan@me.com",
      "Amaan Khalid", "1234567890", @message = "Hello")
  end

end
