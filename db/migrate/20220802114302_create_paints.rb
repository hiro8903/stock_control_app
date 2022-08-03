class CreatePaints < ActiveRecord::Migration[7.0]
  def change
    create_table :paints do |t|
      t.string :name, null: false, index: { unique: true } ,       comment: '塗料の名前'
      t.references :manufacturer, null: false, foreign_key: true,  comment: '塗料の製造元'
      t.float :unit_price,                                         comment: '単価[円/kg]'
      t.float :ordering_point,                                     comment: '発注点[kg]'
      t.string :main_ingredient,                                   comment: '主成分'
      t.integer :warranty,                                         comment: '品質保証期間[日]'

      t.timestamps
    end
  end
end
