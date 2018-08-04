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

    events = @calendar.events

    @team_members = events.flat_map(&:email).uniq
    @events_by_date = events
      .select { |e| e.date >= Date.today }
      .group_by(&:date)
  end
end
