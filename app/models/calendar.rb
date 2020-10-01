class Calendar
  def self.find(id)
    return PagerDutyCalendar.find(id) if id.start_with?("pagerduty")
    return ManualCalendar.find(id) if id.start_with?("manual")
  end
end
