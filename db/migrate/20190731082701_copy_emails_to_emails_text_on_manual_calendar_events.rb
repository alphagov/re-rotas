class CopyEmailsToEmailsTextOnManualCalendarEvents < ActiveRecord::Migration[5.2]
  def up
    ManualCalendarEvent.all.each do |event|
      event.emails_text = event.emails
      event.save
    end
  end

  def down
  end
end
