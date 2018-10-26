class PagerDutyCalendarsController < ApplicationController
  def edit
    @calendar = PagerDutyCalendar.find(params[:id])
  end

  def update
    @calendar = PagerDutyCalendar.find(params[:id])
    @calendar.assign_attributes(params.permit(:name, :url))

    return render :edit unless @calendar.valid?

    @calendar.save
    redirect_to pager_duty_calendar_path(@calendar)
  end
end
