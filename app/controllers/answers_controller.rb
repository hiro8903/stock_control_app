class AnswersController < ApplicationController
  def index

    # 発注情報一覧から、特定の発注の回答一覧を確認するときに発注情報を保持する。
    @order = Order.find(params["order_id"]) if params["order_id"].present?
    # 特定の発注情報を保持していない（ヘッダーから回答一覧ページに遷移する）時、
    # 発注情報を特定せずに全ての回答を回答一覧に表示させる。
    # 特定の回答を保持している時はそれに対する回答のみを表示させる。
    if @order.nil?
      @answers = Answer.all.order(scheduled_at: :ASC)
    else
      @answers = Answer.where(order_id: @order.id).order(scheduled_at: :ASC)
    end
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
    @answer = Answer.find(params[:id])
    @paints = Paint.all
  end

  def update
    @answer = Answer.find(params[:id])
    @answers = Answer.all.order(scheduled_at: :ASC)
    if @answer.update(answer_params)
      @answer.save
      flash[:success] = '更新に成功しました。'
      redirect_to order_answers_url(order_id: @answer.order.id)
    else
      # @answer = Answer.find(params[:id])
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    flash[:success] = "品番：#{@answer.order.paint.name}, 数量：#{@answer.quantity}kg, 
                      納入予定日：#{@answer.scheduled_at.strftime("%Y/%m/%d") }　を削除しました。"
    redirect_to order_answers_url(order_id: @answer.order.id), status: :see_other
  end

  private
    def answer_params
      params.require(:answer).permit(:order_id, :scheduled_at, :quantity, :note)
    end
end
