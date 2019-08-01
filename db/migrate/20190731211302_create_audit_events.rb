class CreateAuditEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_events do |t|
      t.string :email
      t.text :event

      t.timestamps
    end
  end
end
