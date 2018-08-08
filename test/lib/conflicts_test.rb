require 'test_helper'

class WhoIsOnCallConflictTest < ActiveSupport::TestCase
  test 'annual_leave_emails_by_day' do
    assert_equal WhoIsOnCall::Conflicts.annual_leave_emails_by_day([
      AnnualLeaveEvent.new(
        email: 'email',
        start_date: Date.parse('2018-01-01'),
        end_date: Date.parse('2018-01-01'),
      )
    ]), {
      Date.parse('2018-01-01') => ['email'],
    }

    assert_equal WhoIsOnCall::Conflicts.annual_leave_emails_by_day([
      AnnualLeaveEvent.new(
        email: 'email',
        start_date: Date.parse('2018-01-01'),
        end_date: Date.parse('2018-01-02'),
      ),
      AnnualLeaveEvent.new(
        email: 'another',
        start_date: Date.parse('2018-01-02'),
        end_date: Date.parse('2018-01-02'),
      )
    ]), {
      Date.parse('2018-01-01') => ['email'],
      Date.parse('2018-01-02') => ['email', 'another'],
    }
  end

  test 'calculate_conflicts_given_calendar' do
    assert_equal WhoIsOnCall::Conflicts.conflicts_for_calendar(
      Hash.new,
      Hash.new,
    ), Hash.new

    assert_equal WhoIsOnCall::Conflicts.conflicts_for_calendar(
      {
        Date.parse('2018-01-01') => ['email']
      },
      {
        Date.parse('2018-01-01') => [
          WhoIsOnCall::PersonDayEvent.new(nil, 'email', Date.parse('2018-01-01')),
        ]
      }
    ), {
      Date.parse('2018-01-01') => ['email']
    }

    assert_equal WhoIsOnCall::Conflicts.conflicts_for_calendar(
      {
        Date.parse('2018-01-01') => ['email'],
        Date.parse('2018-01-02') => ['another'],
        Date.parse('2018-01-03') => ['email'],
      },
      {
        Date.parse('2018-01-01') => [
          WhoIsOnCall::PersonDayEvent.new(nil, 'email', Date.parse('2018-01-01')),
        ],
        Date.parse('2018-01-02') => [
          WhoIsOnCall::PersonDayEvent.new(nil, 'email', Date.parse('2018-01-02')),
          WhoIsOnCall::PersonDayEvent.new(nil, 'another', Date.parse('2018-01-02')),
        ],
        Date.parse('2018-01-03') => [
          WhoIsOnCall::PersonDayEvent.new(nil, 'email', Date.parse('2018-01-03')),
        ],
      }
    ), {
      Date.parse('2018-01-01') => ['email'],
      Date.parse('2018-01-02') => ['another'],
      Date.parse('2018-01-03') => ['email'],
    }
  end

  test 'find' do
    assert_equal WhoIsOnCall::Conflicts.find(
      Hash.new, Hash.new
    ), Hash.new

    assert_equal WhoIsOnCall::Conflicts.find(
      [
        AnnualLeaveEvent.new(
          email: 'email',
          start_date: Date.parse('2018-01-01'),
          end_date: Date.parse('2018-01-01'),
        )
      ], {
        'cal' => {
          Date.parse('2018-01-01') => [
            WhoIsOnCall::PersonDayEvent.new(nil, 'email', Date.parse('2018-01-01')),
          ]
        },
     }), {
      'cal' => {
        Date.parse('2018-01-01') => ['email']
      },
    }
  end
end
