require_relative 'boot'

require 'csv'
require 'rails/all'

Bundler.require(*Rails.groups)

module Store
  class Application < Rails::Application
    config.load_defaults 5.1
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = true
    config.active_job.queue_adapter = Rails.env.production? ? :sidekiq : :async
  end
end
