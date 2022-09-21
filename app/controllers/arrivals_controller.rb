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

  def create
    @users = User.all
    @order = Order.find(params[:order_id])
    @arrival = @order.arrivals.build(arrival_params)
    if @arrival.save
      flash[:success] = '入荷登録しました。'
      redirect_to orders_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private
    def arrival_params
      params.require(:arrival).permit(:order_id, :user_id, :arrival_at, :lot_number, :quantity)
    end
end
