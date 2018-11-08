class DropTableFriendlyIdSlugs < ActiveRecord::Migration[5.2]
  def change
    drop_table :friendly_id_slugs
  end
end
