class Team < ApplicationRecord
  has_many :pagerduty_calendars, class_name: :PagerDutyCalendar
  has_many :manual_calendars,    class_name: :ManualCalendar

  def calendars
    pagerduty_calendars + manual_calendars
  end

  validates :name, presence: true
end
