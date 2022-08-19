module OrdersHelper

  # 納入予定量回答の総量に対しての注文残量[kg]
  def orders_helper_residual(order)
    answers = order.answers
    answers_total_quantity = 0
    if answers.nil?
      answers_total_quantity
    else
      answers.each do |ans|
        answers_total_quantity =+ ans.quantity if ans.quantity.present?
      end
      order.quantity - answers_total_quantity
    end
  end

end
