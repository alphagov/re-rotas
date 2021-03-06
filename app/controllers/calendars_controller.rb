class CalendarsController < ApplicationController
  def index
    @calendars = PagerDutyCalendar.all + ManualCalendar.all
  end

  def show
    @calendar = Calendar.find(params[:id])

    person_day_events = @calendar.person_day_events

    @team_members = @calendar.members

    @events_by_date = person_day_events
      .group_by(&:date)

    unless params[:all]
      @events_by_date = @events_by_date.reject do |d, _|
        d < Date.today
      end
    end
  end

  def new
    @team = Team.friendly.find(params[:team_id])
  end

  def create
    team = Team.friendly.find(params[:team_id])

    name           = params[:name]
    type           = params[:type].to_sym
    clock          = params[:clock]
    pagerduty_url  = params[:pagerduty_url]

    case type
    when :manual
      ManualCalendar.create(
        team: team,
        name: name,
        clock_type: clock,
      )
    when :pagerduty
      PagerDutyCalendar.create(
        team: team,
        name: name,
        url: pagerduty_url,
        clock_type: clock,
      )
    else
      raise "Unknown calendar type #{type}"
    end

    redirect_to team_path(team)
  end
end
