Rails.application.configure do
  config.cache_classes = true
  # config.cache_store = :file_store, '/tmp'
  #   config.public_file_server.headers = {
  #     'Cache-Control' => "public, max-age=#{1.days.seconds.to_i}"
  #   }

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.read_encrypted_secrets = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.serve_static_assets = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.version = '1.0' 

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  GA.tracker = ENV["google_analitics"]

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.action_mailer.default_url_options = { :host => 'mapapama.heroku.com' }
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
