class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :editor, class_name: "User", foreign_key: "editor_id"
  belongs_to :department
  belongs_to :paint
    with_options presence: true do
    validates :inventory_at
    validates :quantity
  end
  # 塗料棚卸を登録する際、その塗料、部署、年月の組み合わせが一意であること。
  validates :paint_id, uniqueness: {scope: [:department_id, :inventory_at]}
end
