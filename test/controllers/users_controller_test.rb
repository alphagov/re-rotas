require 'test_helper'
require 'helpers/auth_helper'
require 'helpers/teams_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should log an audit event' do
    create_test_session_with_fake_auth

    email = 'log-an-audit-event@test'

    get user_contact_information_path(id: email)
    assert_response :success

    audit_event = AuditEvent.last

    assert_equal audit_event.email, test_session_email

    assert_equal audit_event.event[:message], "Viewed #{email}"
  end
end
