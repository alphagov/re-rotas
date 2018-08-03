module WhoIsOnCall
  class Event

    attr_reader :team, :calendar, :email, :date

    def initialize(team, calendar, email, date)
      @team = team
      @calendar = calendar
      @email = email
      @date = date
    end
  end
end
