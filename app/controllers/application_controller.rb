class ApplicationController < ActionController::Base
  helper_method :email_fmt
  helper_method :current_user_is_email

  private

  def email_fmt(email)
    return email unless email.end_with?('digital.cabinet-office.gov.uk')
    short = email
      .split('@')
      .first.tr('.', ' ')
      .split(' ')
      .map(&:capitalize)
      .join(' ')

    return short unless email.casecmp(google_auth_data.email).zero?

    '<strong class="govuk-tag">You</strong>'.html_safe
  end

  before_action :maybe_redirect_if_not_google_authenticated

  def maybe_redirect_if_not_google_authenticated
    unless params[:controller] == 'pages' && params[:action] == 'home'
      redirect_if_not_google_authenticated unless ENV.fetch('DISABLE_AUTH', false)
    end
  end

  def current_user_is_email(email)
    email.casecmp(google_auth_data.email).zero?
  end
end
