class ApplicationMailer < ActionMailer::Base
  default to: "info@carparkspacebooker.com", from: "info@carparkspacebooker.com"
  layout 'mailer'
end
