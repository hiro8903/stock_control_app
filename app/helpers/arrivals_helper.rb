module ArrivalsHelper
  
  # 入荷量の総量に対しての注文残量[kg]
  def arrivals_helper_residual(order)
    arrivals = order.arrivals
    arrivals_total_quantity = 0
    if arrivals.nil?
      arrivals_total_quantity
    else
      arrivals.each do |arri|
        arrivals_total_quantity += arri.quantity if arri.quantity.present?
      end
    end
    order.quantity - arrivals_total_quantity
  end
end
