class PagerdutyCalendarsController < ApplicationController
  def index
    @calendars = PagerDutyCalendar.all
  end

  def show
    @calendar = PagerDutyCalendar.find(params[:id])
  end

  def new
  end

  def create
  end
end
