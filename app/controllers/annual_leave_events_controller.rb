class AnnualLeaveEventsController < ApplicationController
  def index
    @events = AnnualLeaveEvent.all.order(:start_date, :end_date)
    @events = @events.reject { |e| e.end_date < Date.today } unless params[:all]
  end

  def new
    @event = AnnualLeaveEvent.new
    @event.email = current_user
  end

  def create
    event  = params.permit(:email, :start_date, :end_date)
    @event = AnnualLeaveEvent.new(event)

    return render :new unless @event.valid?

    @event.save
    redirect_to annual_leave_events_path
  end

  def edit
    @event = AnnualLeaveEvent.find(params[:id])
  end

  def update
    @event = AnnualLeaveEvent.find(params[:id])
    @event.assign_attributes(params.permit(:email, :start_date, :end_date))

    return render :edit unless @event.valid?

    @event.save

    redirect_to annual_leave_events_path
  end

  def destroy
    AnnualLeaveEvent.find(params[:id]).destroy
    redirect_to annual_leave_events_path
  end
end
