class AddIsAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false
    add_column :users, :name, :string, null: false, default: ''
  end
end
