class AddSlugToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :slug, :string
  end
end
