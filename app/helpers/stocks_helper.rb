module StocksHelper

  def beginning_stocks(paint)
    AllInventory.find_by(inventory_at: @last_month, paint_id: paint.id)
  end

  def monthly_withdraws_quantity(paint)
    @monthly_withdraws = Withdraw.where(withdraw_at: @first_day..@day, paint_id: paint.id)
    @withdraws_quantity = 0
    @monthly_withdraws.each do |withdraw|
      @withdraws_quantity += withdraw.quantity
    end
    return @withdraws_quantity
  end
  
  def monthly_arrivals_quantity(paint)
    @monthly_arrivals = Arrival.joins(:order).where(arrival_at: @first_day..@day).where(orders: {paint_id: paint.id})

    @arrivals_quantity = 0.0
    @monthly_arrivals.each do |arrival|
      @arrivals_quantity += arrival.quantity
    end
    return @arrivals_quantity
  end

  def stock(paint)
    beginning_stocks(paint).quantity + @arrivals_quantity - @withdraws_quantity
  end
end
