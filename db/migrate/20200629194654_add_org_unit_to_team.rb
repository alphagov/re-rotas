class AddOrgUnitToTeam < ActiveRecord::Migration[6.0]
  def change
    add_reference :teams, :org_unit, foreign_key: true
  end
end
