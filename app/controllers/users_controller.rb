class UsersController < ApplicationController
  def show
    @email = params[:id]

    @on_call_calendars_by_date = Team
      .all
      .flat_map(&:calendars)
      .flat_map(&:person_day_events)
      .select { |e| e.date >= Date.today }
      .select { |e| e.email.casecmp(@email).zero? }
      .reduce({}) do |acc, e|
        acc[e.date] ||= Set.new; acc[e.date].add(e.calendar)
        acc
      end
      .sort_by { |date, _calendars| date }
  end
end
