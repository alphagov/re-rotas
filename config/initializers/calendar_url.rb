require 'securerandom'

calendar_url_salt = if ENV.key?('VCAP_SERVICES')
                      CF::App::Credentials
                        .find_by_service_name('rotas-secrets')
                      &.fetch('calendar-url-salt', nil)
                    else
                      ENV.fetch('CALENDAR_URL_SALT', nil)
                    end || SecureRandom.base64(32)

Rails.application.config.calendar_url_salt = calendar_url_salt
