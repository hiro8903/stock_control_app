module AnswersHelper

# 納入量回答に対しての注文残量[kg]
  def residual(answer)
    if answer.quantity.present?
      answer.order.quantity - answer.quantity == 0 ? "-" : answer.order.quantity - answer.quantity 
    else
      return answer.order.quantity
    end
  end
  
end
