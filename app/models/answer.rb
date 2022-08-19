class Answer < ApplicationRecord
  # include AnswersHelper
  belongs_to :order, class_name: 'Order',foreign_key: 'order_id'
  # validate :quantity_orver

  def quantity_orver
    debugger
    errors.add("発注量を超えています。") if quantity > Answer.order.quantity
  end
end
