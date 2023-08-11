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
    @order_collections = Form::OrderCollection.new
  end

  def create
    @users = User.all
    @paints = Paint.all
    @order_collections = Form::OrderCollection.new(orders_params)
    @order_collections.collection.delete(nil)
    orders_number = @order_collections.collection.count
    @order_collections.collection.each do |order|
      order[:user_id] = params[:form_order_collection][:user_id]
      order[:order_on] = params[:form_order_collection][:order_on]
      order[:desired_on] = params[:form_order_collection][:desired_on]
      order[:registerer_id] = @user.id if order.created_at == order.updated_at
      order[:editor_id] = @user.id
    end
    if @order_collections.save
      flash[:success] = "#{orders_number}件、発注登録しました。"
      redirect_to orders_path
    else
      flash[:danger] = "発注登録に失敗しました。"
      render new_order_path, status: :unprocessable_entity
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

    def orders_params
      params.require(:orders)
    end

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
