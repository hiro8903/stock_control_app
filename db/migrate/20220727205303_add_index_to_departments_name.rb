class AddIndexToDepartmentsName < ActiveRecord::Migration[7.0]
  def change
    add_index :departments, :name
  end
end
