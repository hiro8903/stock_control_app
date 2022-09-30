class Arrival < ApplicationRecord
  belongs_to :order
  belongs_to :user
  with_options presence: true do
    validates :order_id
    validates :user_id
    validates :arrival_at
    validates :quantity
  end
end
