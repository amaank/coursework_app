class ContactMailer < ApplicationMailer

  # Method for sending contact email.
  def contact_email(email, name, telephone, message)
    @email = email
    @name = name
    @telephone = telephone
    @message = message

    mail cc: @email
  end

end
