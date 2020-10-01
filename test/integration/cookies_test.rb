require "test_helper"
require "helpers/auth_helper"
require "time"

class CookiesTest < ActionDispatch::IntegrationTest
  test "cookies are secure" do
    create_test_session_with_fake_auth
    get root_path

    assert_response :success

    assert_not_nil cookies[Rotas::CookieNames::SESSION_COOKIE_NAME]

    # need to use response.headers to verify that SameSite and expiry are set :/
    assert_match /^#{Rotas::CookieNames::SESSION_COOKIE_NAME}=.+$/, response.headers["Set-Cookie"]

    assert_match /SameSite=Lax/, response.headers["Set-Cookie"], "SameSite=Strict not enabled for this app!"

    assert_match /HttpOnly/, response.headers["Set-Cookie"], "HttpOnly not enabled for this app!"

    cookie_expires = response.headers["Set-Cookie"].match(/^.+expires=([^;]+);.+$/)[1]
    assert_not_nil cookie_expires, "Expiry not found in Set-Cookie"
    cookie_expiry_time = Time.parse cookie_expires
    cookie_time_length = 24.hours
    assert cookie_expiry_time > (Time.now + cookie_time_length - 5.minutes), "Cookie expires too early"
    assert cookie_expiry_time < (Time.now + cookie_time_length + 5.minutes), "Cookie expires too late"
  end
end
