class ManualCalendarEventsController < ApplicationController
  def index
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @events = @calendar.events.sort_by { |e| e.start_date }
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
end
