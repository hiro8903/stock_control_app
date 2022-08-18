class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def show
  end

  def new
    @users = User.all
    @paints = Paint.all
    @answer = Answer.new(order_id: params[:order_id])
    @order = @answer.order
  end

  def edit
  end
end
