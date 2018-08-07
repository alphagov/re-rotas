class PagesController < ApplicationController
  def home
  end

  def sign_out
    session.clear
  end
end
