class AddSlugToOrgUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :org_units, :slug, :string
  end
end
