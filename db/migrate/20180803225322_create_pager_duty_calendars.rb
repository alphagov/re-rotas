class CreatePagerDutyCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :pager_duty_calendars, id: false do |t|
      t.string :id
      t.references :team, foreign_key: true
      t.string :name
      t.string :url
      t.string :clock_type

      t.timestamps
    end
  end
end
