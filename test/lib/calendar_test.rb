require "test_helper"
require "minitest/mock"

class RotasCalendarTest < ActiveSupport::TestCase
  test "calendar shows current team members only" do

    class Calendar
      include Rotas::Calendar

      def person_day_events
        [
          Rotas::PersonDayEvent.new(nil, "notcurrent", Date.today - 3),
          Rotas::PersonDayEvent.new(nil, "current", Date.today + 1),
        ]
      end
    end

    calendar = Calendar.new

    members = calendar.members

    assert_equal members.length, 1
    assert_equal members.first, "current"
  end
end
