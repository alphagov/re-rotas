module Rotas
  module Calendar
    def person_day_events
      # returns a flat list of PersonDayEvent
      # i.e. <calendar, email, date>
      dates = Hash.new { |h, k| h[k] = Set.new }

      events.flat_map do |event|
        (event.start_date..event.end_date).flat_map do |date|
          event.emails.flat_map { |email| dates[date] << email }
        end
      end

      dates.flat_map do |date, emails|
        emails.map { |e| Rotas::PersonDayEvent.new(self, e, date) }
      end
    end
  end
end
