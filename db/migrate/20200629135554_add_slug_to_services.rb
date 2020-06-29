class AddSlugToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :slug, :string
  end
end
