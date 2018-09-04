require 'base64'
require 'digest'
require 'json'

module WhoIsOnCall::CalendarUrl
  def self.generate_url(email)
    salt = Rails.application.config.calendar_url_salt

    Base64.urlsafe_encode64({
      email: email,
      hash:  Digest::SHA2.new(256).hexdigest("#{salt}:#{email}"),
    }.to_json)
  end

  def self.email_from_url_fragment(url_fragment)
    salt = Rails.application.config.calendar_url_salt

    email, hash = JSON.parse(
      Base64.urlsafe_decode64(url_fragment)
    ).values_at('email', 'hash')

    hash == Digest::SHA2.new(256).hexdigest("#{salt}:#{email}") ? email : nil
  rescue # rubocop:disable Style/RescueStandardError
    nil
  end
end
