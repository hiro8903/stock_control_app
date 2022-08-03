class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @users = User.order(:name)
    @paints = Paint.order(:discontinue).order(:name)
  end

  def edit
  end
end
