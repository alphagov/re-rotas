require 'http'
require 'icalendar'
require 'securerandom'
require 'set'

class PagerDutyCalendar < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :team

  include WhoIsOnCall::Calendar

  validates :name, presence: true
  validates :url,  presence: true

  validates :clock_type,
            presence: true,
            inclusion: { in: %w[in_hours out_of_hours in_and_out_of_hours] }

  def events
    calendar  = Icalendar::Calendar.parse(StringIO.new(
      WhoIsOnCall::URL_CACHE.fetch(url)
    ))

    calendar
      .flat_map(&:events)
      .map do |icalendar_event|
        start_date = icalendar_event.dtstart.to_date
        end_date   = icalendar_event.dtend.to_date
        emails     = icalendar_event.attendee.map(&:to_s)
        WhoIsOnCall::Event.new(self, emails, start_date, end_date)
      end
  end

  def events_editable?
    false
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "pagerduty:#{SecureRandom.uuid}"
  end
end
