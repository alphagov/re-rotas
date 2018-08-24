require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new session page' do
    get new_session_path
    assert_response :success
  end

  test 'should not get teams page when not signed in' do
    get teams_path
    assert_redirected_to controller: :sessions, action: :new
  end

  test 'should not get calendars page when not signed in' do
    get calendars_path
    assert_redirected_to controller: :sessions, action: :new
  end

  test 'should not a user page when not signed in' do
    get user_path('test')
    assert_redirected_to controller: :sessions, action: :new
  end
end
