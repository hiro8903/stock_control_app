class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :order, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.float :quantity
      t.string :note

      t.timestamps
    end
  end
end
