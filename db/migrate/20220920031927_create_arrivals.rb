class CreateArrivals < ActiveRecord::Migration[7.0]
  def change
    create_table :arrivals do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :arrival_at
      t.string :lot_number
      t.float :quantity

      t.timestamps
    end
  end
end
