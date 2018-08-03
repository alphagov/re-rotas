class Team < ApplicationRecord
  has_many :calendars, class_name: :PagerDutyCalendar
  validates :name, presence: true
end
