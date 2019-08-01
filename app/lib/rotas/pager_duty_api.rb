module Rotas::PagerDutyAPI
  def self.contact_details_for_email(email)
    users_url = "#{api_url}/users"

    user_response = HTTP
      .headers(default_headers)
      .get(users_url, params: {query: email})

    user = JSON.parse(user_response).dig('users').first

    return nil if user.nil?

    contact_methods_url = "#{api_url}/users/#{user['id']}/contact_methods"

    contact_methods_response = HTTP
      .headers(default_headers)
      .get(contact_methods_url)

    contact_methods = JSON
      .parse(contact_methods_response)
      .dig('contact_methods')
  end

  private

  def self.api_url
    'https://api.pagerduty.com/'
  end

  def self.default_headers
    {
      accept: 'application/vnd.pagerduty+json;version=2',
      authorization: "Token token=#{api_key}",
    }
  end

  def self.api_key
    if ENV.key?('VCAP_SERVICES')
      CF::App::Credentials
          .find_by_service_name('rotas-secrets')
          .find_by_service_name('pagerduty-api-key')
    else
      ENV.fetch('PAGERDUTY_API_KEY')
    end
  end
end
