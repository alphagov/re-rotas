class IcalendarsController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in,
                     only: %i(show)
  skip_before_action :maybe_expire_session,
                     only: %i(show)

  def show
    fragment = params[:id]
    email    = WhoIsOnCall::CalendarUrl.email_from_url_fragment(fragment)

    raise ActionController::RoutingError.new('Not Found') if email.blank?

    calendar = Icalendar::Calendar.new

    events = [].concat(
      ManualCalendar.all.flat_map(&:person_day_events),
      PagerDutyCalendar.all.flat_map(&:person_day_events),
    )
      .select { |e| e.email == email }
      .select { |e| e.date >= Date.today }
      .each do |e|
        calendar.event do |event|
          desc = "Oncall #{e.calendar.team.name} | #{e.calendar.name}"

          event.dtstart = e.date
          event.dtend   = e.date + 1
          event.summary = desc
          event.description = desc
        end
      end

    render plain: calendar.to_ical
  end
end
