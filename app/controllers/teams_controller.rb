class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
  end

  def create
    Team.create(name: params[:name])
    redirect_to teams_path
  end

  def show
    @team = Team.find(params[:id])

    @events_by_calendar = {}
    @team_members = []

    @team.calendars.each do |calendar|
      events = calendar.person_day_events

      @team_members += events.flat_map(&:email)

      events.group_by(&:date).each do |date, cal_events|
        @events_by_calendar[date] ||= {}
        @events_by_calendar[date][calendar] = cal_events
      end
    end

    unless params[:all]
      @events_by_calendar = @events_by_calendar.reject do |d, _|
        d < Date.today
      end
    end

    @team_members = @team_members.uniq
  end
end
