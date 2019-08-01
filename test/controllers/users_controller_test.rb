require 'test_helper'
require 'minitest/mock'
require 'helpers/auth_helper'
require 'helpers/teams_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should log an audit event and show contact details correctly' do
    Rotas::PagerDutyAPI.stub(
      :contact_details_for_email, [
        {
          'type'    => 'email_contact_method',
          'address' => 'email-address',
          'label'   => 'Work email',
        },
        {
          'type'    => 'email_contact_method',
          'address' => 'email2-address',
          'label'   => 'Home email',
        },
        {
          'type'    => 'phone_contact_method',
          'address' => 'phone-address',
          'label'   => 'Work phone',
        },
        {
          'type'    => 'phone_contact_method',
          'address' => 'phone2-address',
          'label'   => 'Home phone',
        },
        {
          'type'    => 'sms_contact_method',
          'address' => 'sms-address',
          'label'   => 'Work SMS',
        },
        {
          'type'    => 'push_notification_contact_method',
          'address' => 'push-address',
          'label'   => 'Work push',
        },
      ]
    ) do
      create_test_session_with_fake_auth

      email = 'log-an-audit-event@test'

      get user_contact_information_path(id: email)
      assert_response :success

      audit_event = AuditEvent.last

      assert_equal audit_event.email, test_session_email

      assert_equal audit_event.event[:message],
                   "Viewed the contact details of #{email} from PagerDuty"

      assert_select 'th', /Email/
      assert_select 'td', /email-address/
      assert_select 'td', /Work email/
      assert_select 'td', /email2-address/
      assert_select 'td', /Home email/

      assert_select 'th', /Phone/
      assert_select 'td', /phone-address/
      assert_select 'td', /Work phone/
      assert_select 'td', /phone2-address/
      assert_select 'td', /Home phone/

      assert_select 'th', /SMS/
      assert_select 'td', /sms-address/
      assert_select 'td', /Work SMS/

      assert_select 'th', /Push/
      assert_select 'td', {
        text: /push-address/,
        count: 0,
      }, 'Hide push address as it is meaningless'
      assert_select 'td', /Work push/
    end
  end

  test 'should log an audit event and show a helpful msg when no details' do
    Rotas::PagerDutyAPI.stub(:contact_details_for_email, nil) do
      create_test_session_with_fake_auth

      email = 'log-an-audit-event-404@test'

      get user_contact_information_path(id: email)
      assert_response :success

      audit_event = AuditEvent.last

      assert_equal audit_event.email, test_session_email

      assert_equal audit_event.event[:message],
                   "Viewed the contact details of #{email} from PagerDuty"

      assert_select 'p', /There are no contact details in PagerDuty/
    end
  end
end
