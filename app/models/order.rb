class Order < ApplicationRecord
  belongs_to :paint
  belongs_to :user
  belongs_to :registerer, class_name: "User", foreign_key: "registerer_id"
  belongs_to :editor, class_name: "User", foreign_key: "editor_id"
  has_many :answers, dependent: :destroy
  has_many :arrivals, dependent: :destroy
  with_options presence: true do
    validates :paint_id
    validates :user_id
    validates :order_on
    validates :quantity
  end
end
