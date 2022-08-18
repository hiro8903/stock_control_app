module AnswersHelper

# 納入量回答に対しての注文残量[kg]
  def residual(answer)
    answer.order.quantity - answer.quantity == 0 ? "-" : answer.order.quantity - answer.quantity 
  end
  
end
