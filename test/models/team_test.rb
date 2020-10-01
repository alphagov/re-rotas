require "test_helper"
require "minitest/mock"

class TeamTest < ActiveSupport::TestCase
  test "team has non-empty name" do
    assert_not Team.new(name: "").valid?
  end

  test "team has members" do
    team = Team.new

    class CalendarMock
      include Rotas::Calendar

      def initialize(name)
        @n = name
      end

      def person_day_events
        [
          Rotas::PersonDayEvent.new(nil, "notcurrent@#{@n}", Date.today - 3),
          Rotas::PersonDayEvent.new(nil, "current@#{@n}", Date.today + 1),
        ]
      end
    end

    team.stub(
      :calendars, [
        CalendarMock.new("cal1"),
        CalendarMock.new("cal2"),
      ]
    ) do
      assert_equal team.members, ["current@cal1", "current@cal2"]
    end
  end
end
