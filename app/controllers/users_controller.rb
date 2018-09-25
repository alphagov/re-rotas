class UsersController < ApplicationController
  def show
    @email = params[:id]

    @icalendar_url = icalendar_path(Rotas::CalendarUrl
      .generate_url(@email))

    @rota_calendars_by_date = Team
      .all
      .flat_map(&:calendars)
      .flat_map(&:person_day_events)
      .select { |e| e.date >= Date.today }
      .select { |e| e.email.casecmp(@email).zero? }
      .reduce({}) do |acc, e|
        acc[e.date] ||= Set.new; acc[e.date].add(e.calendar)
        acc
      end

    @annual_leave = AnnualLeaveEvent
      .where(email: @email)
      .flat_map { |e| (e.start_date..e.end_date).map { |d| [d, e] } }
      .to_h

    @earliest           = Date.today
    @latest             = @rota_calendars_by_date.keys.max

    unless @rota_calendars_by_date.empty?
      @next_rota_date  = @rota_calendars_by_date.keys.min
      @days_until_rota = @next_rota_date - Date.today
    end
  end
end
