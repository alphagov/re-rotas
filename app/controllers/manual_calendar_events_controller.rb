class ManualCalendarEventsController < ApplicationController
  def index
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @events   = @calendar.events.sort_by(&:start_date)
  end

  def new
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @event    = ManualCalendarEvent.new(manual_calendar: @calendar)
  end

  def edit
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @event    = ManualCalendarEvent.find(params[:id])
  end

  def create
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @event    = ManualCalendarEvent.new(create_or_update_params)

    return render :new unless @event.valid?

    @event.save
    redirect_to manual_calendar_events_path(@calendar)
  end

  def update
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    @event    = ManualCalendarEvent.find(params[:id])
    @event.assign_attributes(create_or_update_params)

    return render :edit unless @event.valid?
    @event.save

    redirect_to manual_calendar_events_path(@calendar)
  end

  def destroy
    @calendar = ManualCalendar.find(params[:manual_calendar_id])
    ManualCalendarEvent.find(params[:id]).destroy
    redirect_to manual_calendar_events_path(@calendar)
  end

  private

  def create_or_update_params
    {
      manual_calendar_id:   @calendar.id,
      start_date:           params[:start_date],
      end_date:             params[:end_date],
      emails:               params[:emails].lines
                                           .map(&:downcase)
                                           .map(&:strip)
                                           .reject(&:blank?)
                                           .uniq,
    }
  end
end
