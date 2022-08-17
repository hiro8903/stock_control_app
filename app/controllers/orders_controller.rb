class OrdersController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_users, only: [:new, :cretate, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_paints, only:  [:new, :cretate, :edit, :update]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @last_order = Order.all.order(updated_at: :desc).first
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      if @order.unit_price.present?
        @order.total_price = @order.unit_price * @order.quantity
      else
        @order.unit_price = @order.paint.unit_price
        @order.total_price = @order.unit_price * @order.quantity
      end
      @order.save
      flash[:success] = '更新に成功しました。'
      
      redirect_to orders_path
    else
      # @users,@paintsが設定されていないと保存失敗時にrenderした際、それぞれがnilになりエラーになる。
      @users = User.all
      @paints = Paint.order(:discontinue).order(:name)
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.total_price = @order.unit_price * @order.quantity
      @order.save
      flash[:success] = '更新に成功しました。'
      redirect_to orders_path
    else
      @order = Order.find(params[:id])
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    @order.destroy
    flash[:success] = "品番：#{@order.paint.name}, 数量：#{@order.quantity}kg, 
                      納入希望日：#{@order.desired_on.strftime("%Y/%m/%d") }　を削除しました。"
    redirect_to orders_path, status: :see_other
  end
  

  private
    def order_params
      params.require(:order).permit(:paint_id, :user_id, :order_on, :quantity, :desired_on,
                                    :note, :registerer_id, :editor_id, :unit_price, :total_price)
    end
    
    def set_user
      @user = User.find(current_user.id)
    end
    
    def set_users
      @users = User.all
    end
    
    def set_paints
      @paints = Paint.order(:discontinue).order(:name)
    end
    
    # paramsハッシュから発注を取得します。
    def set_order
      @order = Order.find(params[:id])
    end
end
