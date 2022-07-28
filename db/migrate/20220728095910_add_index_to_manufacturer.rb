class AddIndexToManufacturer < ActiveRecord::Migration[7.0]
  def change
    add_index :manufacturers, :name, unique: true
  end
end
