class AddPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :unit_price, :float
    add_column :orders, :total_price, :float
  end
end
