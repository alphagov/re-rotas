class IcalendarsController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in,
                     only: %i(show)
  skip_before_action :maybe_expire_session,
                     only: %i(show)

  def show
    fragment = params[:id]
    email    = Rotas::CalendarUrl.email_from_url_fragment(fragment)

    raise ActionController::RoutingError.new('Not Found') if email.blank?

    calendar = Icalendar::Calendar.new

    [].concat(
      ManualCalendar.all.flat_map(&:person_day_events),
      PagerDutyCalendar.all.flat_map(&:person_day_events),
    )
      .select { |e| e.email == email }
      .each do |e|
        calendar.event do |event|
          desc = "Rota #{e.calendar.team.name} | #{e.calendar.name}"

          event.dtstart = e.date
          event.dtend   = e.date + 1
          event.summary = desc
          event.description = desc
        end
      end

    AnnualLeaveEvent
      .where(email: email)
      .each do |e|
        calendar.event do |event|
          event.dtstart = e.start_date
          event.dtend   = e.end_date
          event.summary = 'Annual leave'
          event.description = 'Annual leave'
        end
      end

    send_data calendar.to_ical, filename: 'rotas.ics', type: 'text/calendar', disposition: 'attachment'
  end
end
