class CreateManualCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :manual_calendars, id: false do |t|
      t.string :id
      t.string :name
      t.references :team, foreign_key: true
      t.string :clock_type

      t.timestamps
    end
  end
end
