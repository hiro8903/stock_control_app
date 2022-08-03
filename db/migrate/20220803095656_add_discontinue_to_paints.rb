class AddDiscontinueToPaints < ActiveRecord::Migration[7.0]
  def change
    add_column :paints, :discontinue, :boolean, default: false
  end
end
