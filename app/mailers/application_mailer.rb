class ApplicationMailer < ActionMailer::Base
  # Define default properties for all mailers.
  default to: "info@parkmycars.com", from: "info@parkmycars.com"
  layout 'mailer'
end
