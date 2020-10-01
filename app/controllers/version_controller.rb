# rubocop:disable Style/ClassVars
require "English"

class VersionController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in, only: %i[version]
  skip_before_action :maybe_expire_session, only: %i[version]

  @@version = nil

  def version
    version = @@version || _version
    render plain: version
  end

private

  def _version
    version = `git rev-parse HEAD`
    version = `cd "#{Rails.application.root}" && git rev-parse HEAD`
    raise version unless $CHILD_STATUS.success?

    @@version = version.chomp
  end
end
