class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :editor
  belongs_to :department
  belongs_to :paint
    with_options presence: true do
    validates :inventory_at
    validates :quantity
  end
end
