class CreateManualCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :manual_calendar_events do |t|
      t.string :manual_calendar_id, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :emails, array: true, default: []

      t.timestamps
    end
  end
end
