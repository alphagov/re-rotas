class AddEmailsTextToManualCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :manual_calendar_events, :emails_text, :text
  end
end
