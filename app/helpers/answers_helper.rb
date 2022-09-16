module AnswersHelper

# 納入予定量回答の総量に対しての注文残量[kg]
  def answers_helper_residual(answer)
    answers = answer.order.answers
    answers_total_quantity = 0
    answers.each do |ans|
      answers_total_quantity += ans.quantity if ans.quantity.present?
    end
    if answers_total_quantity == 0
      return answer.order.quantity
    else
      return answer.order.quantity - answers_total_quantity
    end
  end

  def answer_title(order)
    base_title = "回答一覧"
    if order.nil?
      base_title
    else
      "発注に対する" + base_title
    end
  end
end
