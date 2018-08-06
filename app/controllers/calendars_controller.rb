class CalendarsController < ApplicationController
  def index
    @calendars = PagerDutyCalendar.all + ManualCalendar.all
  end

  def show
    id = params[:id]

    if id.start_with?('pagerduty')
      @calendar = PagerDutyCalendar.find(id)
    else
      @calendar = ManualCalendar.find(id)
    end

    person_day_events = @calendar.person_day_events

    @team_members = person_day_events.flat_map(&:email).uniq
    @events_by_date = person_day_events
      .group_by(&:date)
  end
end
