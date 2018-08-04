class PagerdutyCalendarsController < ApplicationController
  def index
    @calendars = PagerDutyCalendar.all
  end

  def show
    @calendar = PagerDutyCalendar.find(params[:id])
    events = @calendar.events

    @team_members = events.flat_map(&:email).uniq
    @events_by_date = events
      .select { |e| e.date >= Date.today }
      .group_by(&:date)
  end

  def new
  end

  def create
  end
end
