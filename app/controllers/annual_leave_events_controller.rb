class AnnualLeaveEventsController < ApplicationController
  def index
    @events = AnnualLeaveEvent.all.order(:start_date, :end_date)
    @events = @events.reject { |e| e.end_date < Date.today } unless params[:all]
  end

  def new
    @event = AnnualLeaveEvent.new
    @event.email = google_auth_data.email
  end

  def create
    event = params.permit(:email, :start_date, :end_date)
    event[:start_date] = Date.parse(event[:start_date])
    event[:end_date] = Date.parse(event[:end_date])

    puts event.inspect

    AnnualLeaveEvent.create(event)
    redirect_to annual_leave_events_path
  end

  def edit
    @event = AnnualLeaveEvent.find(params[:id])
  end

  def update
    AnnualLeaveEvent
      .find(params[:id])
      .update(params.permit(:email, :start_date, :end_date))
    redirect_to annual_leave_events_path
  end

  def destroy
    AnnualLeaveEvent.find(params[:id]).destroy
    redirect_to annual_leave_events_path
  end
end
