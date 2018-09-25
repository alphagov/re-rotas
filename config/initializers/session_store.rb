Rails.application.config.session_store(
  :cookie_store,
  key: Rotas::CookieNames::SESSION_COOKIE_NAME,
  expire_after: 24.hours,
  same_site: :lax
)
