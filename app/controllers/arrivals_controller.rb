class ArrivalsController < ApplicationController

  # 発注に対する入荷情報一覧ページ
  def index
    @order = Order.find(params[:order_id])
    @arrivals = @order.arrivals
  end

  def index_all
    @arrivals = Arrival.all
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
    @users = User.all
    @paints = Paint.all
    @arrival = Arrival.find(params[:id])
    @order = @arrival.order
    # @answers = @order.answers
    # @arrival = Arrival.new(order_id: params[:order_id])
  end

  def update
    @arrival = Arrival.find(params[:id])
    if @arrival.update(arrival_params)
      flash[:success] = '更新に成功しました。'
      redirect_to order_arrivals_path(order_id: @arrival.order.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @arrival = Arrival.find(params[:id])
    @arrival.destroy
    flash[:success] = "品番：#{@arrival.order.paint.name}, 数量：#{@arrival.quantity}kg, 
                      納入日：#{@arrival.arrival_at.strftime("%Y/%m/%d") }　を削除しました。"
    redirect_to order_arrivals_url(order_id: @arrival.order.id), status: :see_other
  end
  
  
  private
    def arrival_params
      params.require(:arrival).permit(:order_id, :user_id, :arrival_at, :lot_number, :quantity)
    end
end
