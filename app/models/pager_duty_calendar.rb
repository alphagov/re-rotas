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
            inclusion: { in: %w( in_hours out_of_hours in_and_out_of_hours ) }

  def events
    contents  = HTTP.get(url).body
    file      = StringIO.new(contents)
    calendar  = Icalendar::Calendar.parse(file)
    calendar
      .flat_map(&:events)
      .flat_map do |icalendar_event|
        (icalendar_event.dtstart..icalendar_event.dtend).flat_map do |date|
          icalendar_event.attendee.flat_map do |attendee|
            WhoIsOnCall::Event.new(
              @team,
              self,
              attendee.to_s,
              date.to_date
            )
          end
        end
      end
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "pagerduty:#{SecureRandom.uuid}"
  end
end
