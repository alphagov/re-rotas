module WhoIsOnCall
  class Event

    attr_reader :team, :calendar, :emails, :start_date, :end_date

    def initialize(team, calendar, emails, start_date, end_date)
      @team       = team
      @calendar   = calendar
      @emails     = emails
      @start_date = start_date
      @end_date   = end_date
    end
  end
end
