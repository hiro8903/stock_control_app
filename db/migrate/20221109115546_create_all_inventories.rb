class CreateAllInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :all_inventories do |t|
      t.references :paint, null: false, foreign_key: true
      t.date :inventory_at, null: false
      t.float :quantity, null: false, default: 0.0

      t.timestamps
    end
  end
end
