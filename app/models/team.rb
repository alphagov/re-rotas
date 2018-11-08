class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :pagerduty_calendars, class_name: :PagerDutyCalendar
  has_many :manual_calendars,    class_name: :ManualCalendar
  attr_accessor :slug

  validates :name, presence: true

  def calendars
    pagerduty_calendars + manual_calendars
  end
end
