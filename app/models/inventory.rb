class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :editor, class_name: "User", foreign_key: "editor_id"
  belongs_to :department
  belongs_to :paint
    with_options presence: true do
    validates :inventory_at
    validates :quantity
  end
end
