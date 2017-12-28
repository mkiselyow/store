# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Heroku & Devise production
# config.action_mailer.default_url_options = { :host => 'localhost' }
Store::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
      address:              "smtp.gmail.com",
      port:                 587,
      domain:               "max-X751SJ",#"domain.of.sender.net",
      authentication:       "plain",
      user_name:            ENV["email_admin"],
      password:             ENV["password_admin"],
      enable_starttls_auto: true 
  }
end
