class RemoveSlugFromManualCalendar < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :slug
  end
end
