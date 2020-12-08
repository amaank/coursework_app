class HomeController < ApplicationController
  def home
  end

  def contact
  end

  def request_contact
    # Retrieve the required values from the "params" hash.
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    # If no email has been provided.
    if email.blank?
      # Display alert indicating failure to send email.
      flash[:alert] = I18n.t('home.request_contact.no_email')
    else
      # Call appropriate mailer.
      ContactMailer.contact_email(email, name, telephone, message).deliver_now
      # Display notice indicating successful sending of email.
      flash[:notice] = I18n.t('home.request_contact.email_sent')
    end

    # Redirect to the home view regardless of whether or not email is sent.
    redirect_to root_path
  end

end
