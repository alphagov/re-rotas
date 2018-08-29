random_key      = SecureRandom.base64(128)
secret_key_base = if ENV.key?('VCAP_SERVICES')
                    CF::App::Credentials
                      .find_by_service_name('oncall-secrets')
                      &.fetch('secret-key-base', nil)
                  else
                    ENV.fetch('SECRET_KEY_BASE', nil)
                  end || random_key

Rails.application.secrets.secret_key_base = secret_key_base
