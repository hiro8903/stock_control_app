class AddRegistererToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :registerer, null: false, foreign_key: { to_table: :users }
  end
end
