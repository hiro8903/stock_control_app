class Answer < ApplicationRecord
  # include AnswersHelper
  belongs_to :order, class_name: 'Order',foreign_key: 'order_id'
end