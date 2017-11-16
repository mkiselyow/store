Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.authentication_keys = [:email]

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  config.omniauth :facebook, '1804053019906989', 'be6337a5233bcceedbf7c4ca0681723d', scope: 'email', info_fields: 'email,first_name,last_name'
  config.omniauth :vkontakte, '6260391', 'VsjWOjZPGhACH6LfPwze', scope: 'email'
  config.omniauth :instagram, '08c2910a5a6944079701ac634292fe32', 'ec319ae71c98458d82490a5e4119f149', scope: 'basic public_content'
end
