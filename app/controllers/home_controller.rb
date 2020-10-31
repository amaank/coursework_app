class HomeController < ApplicationController
  def home
  end

  def contact
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    if email.blank?
      # Display alert indicating failure to send email.
      flash[:alert] = I18n.t('home.request_contact.no_email')
    else
      # call appropriate mailer
      ContactMailer.contact_email(email, name, telephone, message).deliver_now
      # Display notice indicating successful sending of email.
      flash[:notice] = I18n.t('home.request_contact.email_sent')
    end

    redirect_to root_path
  end

end
