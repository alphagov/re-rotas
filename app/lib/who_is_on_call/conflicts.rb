module WhoIsOnCall::Conflicts
  def self.find(annual_leave_events, calendars_day_and_events)
    calendars_day_and_events
      .map { |calendar, events_by_date|
        [
          calendar,
          conflicts_for_calendar(
            annual_leave_emails_by_day(annual_leave_events),
            events_by_date,
          )
        ]
      }
      .to_h
  end

  def self.conflicts_for_calendar(al_emails_by_day, cal_emails_by_day)
    (al_emails_by_day.keys | cal_emails_by_day.keys)
      .map { |date| get_conflicts(date, al_emails_by_day, cal_emails_by_day) }
      .reject { |_, intersection| intersection.empty? }
      .to_h
  end

  def self.annual_leave_emails_by_day(annual_leave_events)
    annual_leave_events
      .flat_map { |a| (a.start_date..a.end_date).map { |d| [d, a.email] } }
      .group_by { |d, _| d }
      .map { |d, pairs| [d, pairs.map { |_, v| v }] }
      .to_h
  end

  def self.get_conflicts(date, al_emails_by_day, cal_emails_by_day)
    leave_emails = al_emails_by_day.fetch(date, [])
    cal_emails   = cal_emails_by_day.fetch(date, []).map(&:email)

    intersection = leave_emails & cal_emails

    [date, intersection]
  end

  private_class_method :get_conflicts
end
