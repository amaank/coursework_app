class ApplicationMailer < ActionMailer::Base
  # Define default properties for all mailers.
  default to: "info@carparkspacebooker.com", from: "info@carparkspacebooker.com"
  layout 'mailer'
end
