require_relative 'boot'
require_relative '../app/middleware/block_ip_list'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HoneyPot
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.middleware.use BlockIpList
    config.middleware.use Rack::Attack

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV['SMTP_ADDRESS'],
      port: 587,
      domain: ENV['DOMAIN'],
      user_name: 'apikey',
      password: ENV['SEND_GRID_API_KEY'],
      authentication: 'plain',
      enable_starttls_auto: true
    }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
