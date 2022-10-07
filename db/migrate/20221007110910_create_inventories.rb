class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :editor, foreign_key: { to_table: :users }
      t.references :department, null: false, foreign_key: true
      t.date :inventory_at, null: false
      t.references :paint, null: false, foreign_key: true
      t.float :quantity, null: false

      t.timestamps
    end
  end
end
