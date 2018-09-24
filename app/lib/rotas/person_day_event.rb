module Rotas
  class PersonDayEvent
    attr_reader :calendar, :email, :date

    def initialize(calendar, email, date)
      @calendar = calendar
      @email    = email
      @date     = date
    end
  end
end
