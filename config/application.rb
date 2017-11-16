require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Store
  class Application < Rails::Application
    config.load_defaults 5.1
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
  end
end
