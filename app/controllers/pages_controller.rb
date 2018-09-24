class PagesController < ApplicationController
  def home
    teams_with_empty_events = Team.all.map { |t| [t, []] }.to_h
    events_by_team = Team
      .all
      .flat_map(&:calendars)
      .flat_map(&:person_day_events)
      .select { |e| e.date == Date.today }
      .group_by { |e| e.calendar.team }

    @team_rotas = teams_with_empty_events.merge(events_by_team)
  end
end
