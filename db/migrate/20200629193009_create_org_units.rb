class CreateOrgUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :org_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
