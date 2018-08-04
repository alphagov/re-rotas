class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])

    @events_by_calendar = {}
    @team_members = []

    @team.calendars.each do |calendar|
      events = calendar.events.select { |e| e.date >= Date.today }

      @team_members += events.flat_map(&:email)

      events.group_by(&:date).each do |date, cal_events|
        @events_by_calendar[date] ||= {}
        @events_by_calendar[date][calendar] = cal_events
      end
    end

    @team_members = @team_members.uniq
  end

  def new
  end

  def create
  end
end
