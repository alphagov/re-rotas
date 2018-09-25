require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GdsRotas
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Add recommended security headers and apply a basic lenient Content Security Policy
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'DENY',
      'X-XSS-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff',
      'Content-Security-Policy' => "default-src 'self'; " +
        "font-src 'self' data:; " +
        "img-src 'self'; " +
        "object-src 'none'; " +
        # the script digests are for the inline script in govuk-frontend/template.njk
        # if the scripts in that file change, or more are added, use a command similar to
        # this to generate the digests:
        # `echo "'sha256-"$(echo -n "document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');" | openssl dgst -sha256 -binary | openssl enc -base64)"'"`
        "script-src 'self' 'sha256-+6WnXIl4mbFTCARd8N3COQmT3bJJmo32N8q8ZSQAIcU=' 'unsafe-inline'; " +
        "style-src 'self' 'unsafe-inline'"
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    config.autoload_paths << config.root.join('lib')

    config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new(
      min_threads: 1,
      max_threads: 4,
      idletime: 600.seconds,
    )
  end
end
