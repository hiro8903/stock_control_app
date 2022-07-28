class RemoveIndexFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :name
  end
end
