class PagesController < ApplicationController
  def home
    @teams_on_call = Team
      .all
      .flat_map(&:calendars)
      .flat_map(&:person_day_events)
      .select { |e| e.date == Date.today }
      .group_by { |e| e.calendar.team }
  end

  def sign_out
    session.clear
    redirect_to root_path
  end
end
