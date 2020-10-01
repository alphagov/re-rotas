class ManualCalendarEvent < ApplicationRecord
  belongs_to :manual_calendar

  validates :start_date, presence: true
  validates :end_date,   presence: true
  validate :end_date_after_start_date?

  serialize :emails, Array

private

  def end_date_after_start_date?
    if start_date && end_date && end_date < start_date
      errors.add :end_date, "must be equal to, or later than start date"
    end
  end
end
