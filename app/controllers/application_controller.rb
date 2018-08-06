class ApplicationController < ActionController::Base
  helper_method :gds_email_fmt
  helper_method :gds_email_fmt

  private

  def current_user
    'toby.lornewelch-richards@digital.cabinet-office.gov.uk'
  end

  def gds_email_fmt(email)
    return email unless email.end_with?('digital.cabinet-office.gov.uk')
    short = email
      .split('@')
      .first.tr('.', ' ')
      .split(' ')
      .map(&:capitalize)
      .join(' ')

    return short unless email.casecmp(current_user).zero?

    '<strong class="govuk-tag">You</strong>'.html_safe
  end

end
