require "test_helper"

class RotasConflictTest < ActiveSupport::TestCase
  test "annual_leave_emails_by_day" do
    assert_equal Rotas::Conflicts.annual_leave_emails_by_day([
      AnnualLeaveEvent.new(
        email: "email",
        start_date: Date.parse("2018-01-01"),
        end_date: Date.parse("2018-01-01"),
      )
    ]), {
      Date.parse("2018-01-01") => %w[email],
    }

    assert_equal Rotas::Conflicts.annual_leave_emails_by_day([
      AnnualLeaveEvent.new(
        email: "email",
        start_date: Date.parse("2018-01-01"),
        end_date: Date.parse("2018-01-02"),
      ),
      AnnualLeaveEvent.new(
        email: "another",
        start_date: Date.parse("2018-01-02"),
        end_date: Date.parse("2018-01-02"),
      )
    ]), {
      Date.parse("2018-01-01") => %w[email],
      Date.parse("2018-01-02") => %w[email another],
    }
  end

  test "calculate_conflicts_given_calendar" do
    assert_equal Rotas::Conflicts.conflicts_for_calendar(
      Hash.new,
      Hash.new,
    ), Hash.new

    assert_equal Rotas::Conflicts.conflicts_for_calendar(
      {
        Date.parse("2018-01-01") => %w[email]
      },
      {
        Date.parse("2018-01-01") => [
          Rotas::PersonDayEvent.new(nil, "email", Date.parse("2018-01-01")),
        ]
      }
    ), {
      Date.parse("2018-01-01") => %w[email]
    }

    assert_equal Rotas::Conflicts.conflicts_for_calendar(
      {
        Date.parse("2018-01-01") => %w[email],
        Date.parse("2018-01-02") => %w[another],
        Date.parse("2018-01-03") => %w[email],
      },
      {
        Date.parse("2018-01-01") => [
          Rotas::PersonDayEvent.new(nil, "email", Date.parse("2018-01-01")),
        ],
        Date.parse("2018-01-02") => [
          Rotas::PersonDayEvent.new(nil, "email", Date.parse("2018-01-02")),
          Rotas::PersonDayEvent.new(nil, "another", Date.parse("2018-01-02")),
        ],
        Date.parse("2018-01-03") => [
          Rotas::PersonDayEvent.new(nil, "email", Date.parse("2018-01-03")),
        ],
      }
    ), {
      Date.parse("2018-01-01") => %w[email],
      Date.parse("2018-01-02") => %w[another],
      Date.parse("2018-01-03") => %w[email],
    }
  end

  test "find" do
    assert_equal Rotas::Conflicts.find(
      Hash.new, Hash.new
    ), Hash.new

    assert_equal Rotas::Conflicts.find(
      [
        AnnualLeaveEvent.new(
          email: "email",
          start_date: Date.parse("2018-01-01"),
          end_date: Date.parse("2018-01-01"),
        )
      ], {
        "cal" => {
          Date.parse("2018-01-01") => [
            Rotas::PersonDayEvent.new(nil, "email", Date.parse("2018-01-01")),
          ]
        },
     }), {
      "cal" => {
        Date.parse("2018-01-01") => %w[email]
      },
    }
  end
end
