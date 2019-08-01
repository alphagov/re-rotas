class ApplicationController < ActionController::Base
  helper_method :name_fmt
  helper_method :email_fmt
  helper_method :current_user_is_email
  helper_method :current_user
  helper_method :people_finder_url

  before_action :maybe_expire_session
  before_action :maybe_redirect_if_not_signed_in

  rescue_from Rotas::Errors::AuthorisationError do
    redirect_to new_session_path, alert: Rotas::Errors::AuthorisationError.message
  end

private
  def name_fmt(email)
    short = email.split('.').first.capitalize

    return short unless email&.casecmp(current_user)&.zero?

    '<strong class="govuk-tag">You</strong>'.html_safe
  end

  def email_fmt(email)
    return email unless email.end_with?('digital.cabinet-office.gov.uk')

    short = email
      .split('@')
      .first.tr('.', ' ')
      .gsub(/[0-9]/, '')
      .split(' ')
      .map(&:capitalize)
      .join(' ')

    return short unless email&.casecmp(current_user)&.zero?

    '<strong class="govuk-tag">You</strong>'.html_safe
  end

  def people_finder_url(email)
    slug = email.split('@').first.downcase.tr('.', '-')
    "https://peoplefinder.cabinetoffice.gov.uk/people/#{slug}"
  end

  def current_user_is_email(email)
    current_user&.casecmp(email)&.zero?
  end

  def current_user
    return 'disable@auth.user' if ENV.fetch('DISABLE_AUTH', nil)
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

    if request.method == 'GET'
      session[:redirect_path] = request.fullpath
    end

    redirect_to new_session_path
  end
end
