class ApplicationController < ActionController::Base
  helper_method :email_fmt
  helper_method :current_user_is_email
  helper_method :current_user

  before_action :maybe_expire_session
  before_action :maybe_redirect_if_not_signed_in

  private

  def email_fmt(email)
    return email unless email.end_with?('digital.cabinet-office.gov.uk')
    short = email
      .split('@')
      .first.tr('.', ' ')
      .split(' ')
      .map(&:capitalize)
      .join(' ')

    return short unless email&.casecmp(current_user)&.zero?

    '<strong class="govuk-tag">You</strong>'.html_safe
  end

  def current_user_is_email(email)
    email.casecmp(current_user).zero?
  end

  def current_user
    session.fetch(:email, nil)
  end

  def maybe_expire_session
    return if ENV.fetch('DISABLE_AUTH', nil)

    timestamp           = session.fetch(:timestamp, Time.new(0))
    oldest_session_time = Time.now - 30.minutes
    session.clear if timestamp < oldest_session_time
  end

  def maybe_redirect_if_not_signed_in
    return if ENV.fetch('DISABLE_AUTH', nil)
    return if current_user

    redirect_to new_session_path
  end
end
