class UsersController < ApplicationController
  def show
    @email = params[:id]

    @icalendar_url = icalendar_path(WhoIsOnCall::CalendarUrl
      .generate_url(@email))

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

    @annual_leave = AnnualLeaveEvent
      .where(email: @email)
      .flat_map { |e| (e.start_date..e.end_date).map { |d| [d, e] } }
      .to_h

    @earliest           = Date.today
    @latest             = @on_call_calendars_by_date.keys.sort.last

    unless @on_call_calendars_by_date.empty?
      @next_on_call_date  = @on_call_calendars_by_date.keys.sort.first
      @days_until_on_call = @next_on_call_date - Date.today
    end
  end
end
