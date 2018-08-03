require 'test_helper'

class PagerDutyCalendarTest < ActiveSupport::TestCase
  setup do
    @stub_team = Team.new(name: 'stub')
  end

  teardown do
    @stub_team.destroy
  end

  test 'calendar must have name' do
    assert_not PagerDutyCalendar.new(
      name: '',
      team: @stub_team,
      url:  'https://govukpay.pagerduty.com/private/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/feed/AAAAAAA',
			clock_type: 'in_hours',
    ).valid?
  end

  test 'calendar must have valid clock type' do
    assert_not PagerDutyCalendar.new(
      name: 'calendar',
      team: @stub_team,
      url:  'https://govukpay.pagerduty.com/private/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/feed/AAAAAAA',
			clock_type: :something,
    ).valid?

    assert PagerDutyCalendar.new(
      name: 'calendar',
      team: @stub_team,
      url:  'https://govukpay.pagerduty.com/private/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/feed/AAAAAAA',
			clock_type: 'in_hours',
    ).valid?

    assert PagerDutyCalendar.new(
      name: 'calendar',
      team: @stub_team,
      url:  'https://govukpay.pagerduty.com/private/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/feed/AAAAAAA',
			clock_type: 'out_of_hours',
    ).valid?

    assert PagerDutyCalendar.new(
      name: 'calendar',
      team: @stub_team,
      url:  'https://govukpay.pagerduty.com/private/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/feed/AAAAAAA',
			clock_type: 'in_and_out_of_hours',
    ).valid?
  end
end
