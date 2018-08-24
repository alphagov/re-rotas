class TestSessionController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in
  skip_before_action :maybe_expire_session

  def create
    session[:email]        = "emailyemail.emailyemail@digital.cabinet-office.gov.uk"
    session[:timestamp]    = Time.now
  end
end
