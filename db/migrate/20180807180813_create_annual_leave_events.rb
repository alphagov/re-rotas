class CreateAnnualLeaveEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :annual_leave_events do |t|
      t.string :email
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
