class AddIndexToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_index :suppliers, :name, unique: true
  end
end
