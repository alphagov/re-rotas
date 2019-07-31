class DropEmailsFromManualCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :manual_calendar_events, :emails
    rename_column :manual_calendar_events, :emails_text, :emails
  end
end
