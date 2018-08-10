require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GdsWhoIsOnCall
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    config.autoload_paths << config.root.join('lib')

    unless ENV['DISABLE_AUTH']
      SimpleGoogleAuth.configure do |config|
        config.client_id     = ENV.fetch('GOOGLE_AUTH_CLIENT_ID')
        config.client_secret = ENV.fetch('GOOGLE_AUTH_CLIENT_SECRET')
        config.redirect_uri  = 'http://localhost:3000/google-callback'
        config.authenticate  = lambda do |data|
          data.email.ends_with?('@digital.cabinet-office.gov.uk')
        end
      end
    end

    config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new(
      min_threads: 1,
      max_threads: 4,
      idletime: 600.seconds,
    )
  end
end
