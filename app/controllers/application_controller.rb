class ApplicationController < ActionController::Base
  helper_method :gds_email_fmt

  private

  def gds_email_fmt(email)
    return email unless email.end_with?('digital.cabinet-office.gov.uk')
    email.split('@').first.tr('.', ' ').split(' ').map(&:capitalize).join(' ')
  end
end
