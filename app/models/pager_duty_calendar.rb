require 'http'
require 'icalendar'

class PagerDutyCalendar < ApplicationRecord
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
        (icalendar_event.dtstart..icalendar_event.dtend).map do |date|
          WhoIsOnCall::Event.new(
            @team,
            self,
            icalendar_event.attendee.to_s,
            date
          )
        end
      end
  end
end
