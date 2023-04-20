class CreateApiV1Movies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :gender, null: false
      t.date :release_date
      t.date :added_date, null: false
      t.decimal :daily_rental_price, null: false
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
