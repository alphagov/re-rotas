random_key   = SecureRandom.base64(128)
random_token = SecureRandom.base64(128)

secret_key_base = if ENV.key?('VCAP_SERVICES')
                    CF::App::Credentials
                      .find_by_service_name('oncall-secrets')
                      &.fetch('secret-key-base', nil)
                  else
                    ENV.fetch('SECRET_KEY_BASE', nil)
                  end || random_key

secret_token = if ENV.key?('VCAP_SERVICES')
                 CF::App::Credentials
                   .find_by_service_name('oncall-secrets')
                   &.fetch('secret-token', nil)
               else
                 ENV.fetch('SECRET_TOKEN', nil)
               end || random_token

Rails.application.secrets.secret_key_base = secret_key_base
Rails.application.secrets.secret_token    = secret_token
