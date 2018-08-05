require 'securerandom'

class ManualCalendar < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :team

  def person_day_events
    []
  end

  def events
    []
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "manual:#{SecureRandom.uuid}"
  end
end
