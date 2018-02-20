require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Korujams
  class Application < Rails::Application
     
  config.generators do |g|
    g.test_framework :minitest, spec: true, fixture: true
    g.helper false
    g.assets false
    g.view_specs false
  end
  
    # the layout for devise
    config.to_prepare do
      Devise::SessionsController.layout "paper_kit"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "paper_kit" : "paper_ui_kit" }
      Devise::ConfirmationsController.layout "paper_kit"
      Devise::UnlocksController.layout "devise"            
      Devise::PasswordsController.layout "devise"        
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    # the global google analytics tracking
    config.middleware.use Rack::GoogleAnalytics, :tracker => 'UA-44991916-7'
  end
end
