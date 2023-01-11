class CreateWithdrawCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :withdraw_collections do |t|
      t.datetime :withdraw_at, null: false
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.references :paint, null: false, foreign_key: true
      t.string :lot_number
      t.float :quantity, null: false

      t.timestamps
    end
  end
end
