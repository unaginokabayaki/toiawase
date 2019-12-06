require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # I18n.available_locales = %i(ja en)
    # I18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  end
end
