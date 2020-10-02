require "English"

class VersionController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in, only: %i[version]
  skip_before_action :maybe_expire_session, only: %i[version]

  def version
    render "version.txt"
  end
end
