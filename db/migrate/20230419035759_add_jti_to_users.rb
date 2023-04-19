# frozen_string_literal: true

# Add JTI column matcher column to disable api ket generated
class AddJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
