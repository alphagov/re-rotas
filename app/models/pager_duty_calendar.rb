require 'http'
require 'icalendar'
require 'securerandom'

class PagerDutyCalendar < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :team

  validates :name, presence: true
  validates :url,  presence: true

  validates :clock_type,
            presence: true,
            inclusion: { in: %w[in_hours out_of_hours in_and_out_of_hours] }

  def person_day_events
    # returns a flat list of PersonDayEvent
    # i.e. <team, calendar, email, date>
    events.flat_map do |event|
      (event.start_date..event.end_date).flat_map do |date|
        event.emails.flat_map do |email|
          WhoIsOnCall::PersonDayEvent.new(event.team, self, email, date)
        end
      end
    end
  end

  def events
    contents  = HTTP.get(url).body
    calendar  = Icalendar::Calendar.parse(StringIO.new(contents))

    calendar
      .flat_map(&:events)
      .map do |icalendar_event|
        start_date = icalendar_event.dtstart
        end_date   = icalendar_event.dtend
        emails     = icalendar_event.attendee.map(&:to_s)
        WhoIsOnCall::Event.new(team, self, emails, start_date, end_date)
      end
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "pagerduty:#{SecureRandom.uuid}"
  end
end
