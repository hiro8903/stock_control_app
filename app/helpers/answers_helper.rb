module AnswersHelper

# 納入量回答に対しての注文残量[kg]
  def residual(answer)
    answers = answer.order.answers
    answers_total_quantity = 0
    answers.each do |ans|
      answers_total_quantity =+ ans.quantity
    end
    if answers_total_quantity != 0
      (answer.order.quantity - answers_total_quantity) == 0.0 ? "-" : (answer.order.quantity - answers_total_quantity)
    end
  end
  
  # 納入量回答に対しての注文残量[kg]
  # def residual(answer)
  #   if answer.quantity.present?
  #     answer.order.quantity - answer.quantity == 0 ? "-" : answer.order.quantity - answer.quantity 
  #   else
  #     return answer.order.quantity
  #   end
  # end
end
