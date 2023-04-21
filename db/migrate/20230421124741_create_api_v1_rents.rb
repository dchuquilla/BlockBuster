# frozen_string_literal: true

# Cretate the Rent table into DB
class CreateApiV1Rents < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_rents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.date :rent_date, null: false
      t.date :return_date
      t.integer :rent_period, null: false
      t.decimal :total_price, null: false
      t.decimal :total_fine

      t.timestamps
    end
  end
end
