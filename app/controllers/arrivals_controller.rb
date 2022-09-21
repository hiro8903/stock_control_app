class ArrivalsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @users = User.all
    @paints = Paint.all
    @order = Order.find(params[:order_id])
    @answers = @order.answers
    @arrival = Arrival.new(order_id: params[:order_id])
  end

  def edit
  end
end
