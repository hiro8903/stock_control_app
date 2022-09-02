class AnswersController < ApplicationController
  def index
    # 1つの発注に対する納期回答を全てを取得。
    # @order = Order.find(params[:order_id])
    @answers = Answer.all.order(scheduled_at: :ASC)
  end

  def show
  end

  def new
    @users = User.all
    @paints = Paint.all
    @answer = Answer.new(order_id: params[:order_id])
    @order = @answer.order
    @total = 0
    @answer.order.answers.each do |answer|
      @total =+ answer.quantity
    end
  end

  def create
    @order = Order.find(params[:order_id])
    @answer = @order.answers.build(answer_params)
    if @answer.save
      flash[:success] = '回答登録しました。'
      redirect_to orders_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  private
    def answer_params
      params.require(:answer).permit(:order_id, :scheduled_at, :quantity, :note)
    end
end
