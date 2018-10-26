require 'test_helper'
require 'helpers/auth_helper'
require 'time'

class PagerDutyCalendarsTest < ActionDispatch::IntegrationTest
  setup do
    @team     = Team.create(name: 'myteam')
    @calendar = PagerDutyCalendar.create(
      name: 'mypdcal',
      url:  'https://example.com',
      team: @team,
      clock_type: :in_hours,
    )
  end

  teardown do
    @calendar.delete
    @team.delete
  end

  test "pagerduty calendars work correctly" do
    create_test_session_with_fake_auth

    get edit_pager_duty_calendar_path(@calendar.id)
    assert_response :success

    patch pager_duty_calendar_path(@calendar.id),
          params: {
            id:   @calendar.id,
            name: 'mypdcalchanged',
            url:  'https://gov.uk',
          }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    calendar = PagerDutyCalendar.find(@calendar.id)
    assert_equal calendar.name, 'mypdcalchanged'
    assert_equal calendar.url,  'https://gov.uk'
  end
end
