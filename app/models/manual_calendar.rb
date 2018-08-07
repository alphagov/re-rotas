require 'securerandom'

class ManualCalendar < ApplicationRecord
  self.primary_key = 'id'

  has_many :manual_calendar_events, class_name: :ManualCalendarEvent
  belongs_to :team

  validates :name, presence: true

  validates :clock_type,
            presence: true,
            inclusion: { in: %w[in_hours out_of_hours in_and_out_of_hours] }

  include WhoIsOnCall::Calendar

  def events
    manual_calendar_events.order(:start_date).order(:end_date)
  end

  def events_editable?
    true
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "manual:#{SecureRandom.uuid}"
  end
end
