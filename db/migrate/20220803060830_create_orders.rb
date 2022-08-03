class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :paint, null: false, foreign_key: true, index: { unique: true } ,  comment: '発注塗料' 
      t.references :user, null: false, foreign_key: true,                             comment: '発注者'
      t.datetime :order_on, null: false,                                              comment: '発注日'
      t.float :quantity, null: false,                                                 comment: '発注量[kg]' 
      t.datetime :desired_on,                                                         comment: '納入希望日'
      t.string :note,                                                                 comment: '備考'

      t.timestamps
    end
  end
end
