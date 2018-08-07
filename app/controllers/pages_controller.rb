class PagesController < ApplicationController
  def home
  end

  def sign_out
    session.clear
    redirect_to root_path
  end
end
