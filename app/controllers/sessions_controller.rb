class SessionsController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in,
                     only: %i(new create callback)
  skip_before_action :maybe_expire_session,
                     only: %i(new create callback)

  def new; end

  def create
    session[:state] = SecureRandom.hex

    query = {
      scope:         "email",
      response_type: "code",
      state:         session[:state],
      redirect_uri:  callback_url,
      client_id:     google_client_id,
    }
    url = "https://accounts.google.com/o/oauth2/v2/auth?#{query.to_query}"

    redirect_to url
  end

  def callback
    state = params[:state]
    code  = params[:code]

    unless state == session[:state]
      raise Rotas::Errors::AuthorisationError
    end

    payload = {
      client_id:     google_client_id,
      client_secret: google_client_secret,
      code:          code,
      state:         state,
      redirect_uri:  callback_url,
      grant_type:    "authorization_code"
    }

    oauth_response = HTTP.post(
      "https://www.googleapis.com/oauth2/v4/token",
      form: payload
    )
    oauth_parsed = JSON.parse(oauth_response.body)

    access_token = oauth_parsed["access_token"]
    id_token     = oauth_parsed["id_token"]

    me_response = HTTP.get(
      "https://www.googleapis.com/userinfo/v2/me?access_token=#{access_token}"
    )
    me_parsed = JSON.parse(me_response)
    email     = me_parsed["email"]

    unless Rotas::Authorisation.email_authorised?(email)
      raise Rotas::Errors::AuthorisationError
    end

    session[:email]        = email
    session[:access_token] = access_token
    session[:id_token]     = id_token
    session[:timestamp]    = Time.now

    if session.key? :redirect_path
      redirect_path = session[:redirect_path]
      session.delete(:redirect_path)
      redirect_to(redirect_path)
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to new_session_path
  end

private

  def callback_url
    case ENV["RAILS_ENV"]
    when "production"
      "https://rotas.cloudapps.digital/session/callback"
    else
      "http://localhost:3000/session/callback"
    end
  end

  def google_client_id
    ENV.fetch("GOOGLE_AUTH_CLIENT_ID") do
      CF::App::Credentials
        .find_by_service_name("rotas-secrets")["google-client-id"]
    end
  end

  def google_client_secret
    ENV.fetch("GOOGLE_AUTH_CLIENT_SECRET") do
      CF::App::Credentials
        .find_by_service_name("rotas-secrets")["google-client-secret"]
    end
  end
end
