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
      address:              "smtp.i.ua",
      port:                 587,
      domain:               "http://www.mapapama.com.ua",#"domain.of.sender.net",
      authentication:       "plain",
      user_name:            "mapapama.com.ua@gmail.com",
      password:             "16121991nld",
      enable_starttls_auto: true 
  }
end
