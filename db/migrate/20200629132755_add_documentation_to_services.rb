class AddDocumentationToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :documentation, :text
  end
end
