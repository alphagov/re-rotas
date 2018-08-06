require 'securerandom'

class ManualCalendar < ApplicationRecord
  self.primary_key = 'id'

  has_many :manual_calendar_events, class_name: :ManualCalendarEvent
  belongs_to :team

  include WhoIsOnCall::Calendar

  def events
    manual_calendar_events
  end

  def events_editable?
    true
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "manual:#{SecureRandom.uuid}"
  end
end
