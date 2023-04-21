class CreateApiV1Tickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :rent, null: false, foreign_key: true
      t.string :code, null: false
      t.date :issue_date, null: false
      t.decimal :total_price, null: false

      t.timestamps
    end
    add_index :tickets, :code, unique: true
  end
end
