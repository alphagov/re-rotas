module WhoIsOnCall
  class Event
    attr_reader :calendar, :emails, :start_date, :end_date

    def initialize(calendar, emails, start_date, end_date)
      @calendar   = calendar
      @emails     = emails
      @start_date = start_date
      @end_date   = end_date
    end
  end
end
