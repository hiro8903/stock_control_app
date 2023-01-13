class WithdrawsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_day, only: [:index]
  before_action :set_withdraw, only: [:edit, :update, :destroy]

  def index
    @day = Date.current
    @withdraws = Withdraw.where(department_id: current_user.department.id)
    # @department_monthly_withdraws = @withdraws.where(withdraw_at: @first_day..@last_day).includes(:paint).order("paints.name ASC") if @withdraw.present? && @user.department_id.present?
    @department_monthly_withdraws = @withdraws.where(withdraw_at: @first_day..@last_day) if @withdraws.present? && @user.department_id.present?
  end

  def show
  end

  def new
    @paints = Paint.all
    @withdraw_collections = Form::WithdrawCollection.new
  end

  def create
    @paints = Paint.all
    @withdraw_collections = Form::WithdrawCollection.new(withdraws_params)
    @withdraw_collections.collection.delete(nil)
    withdraws_number = @withdraw_collections.collection.count
    @withdraw_collections.collection.each do |withdraw|
      withdraw[:withdraw_at] = params[:form_withdraw_collection][:withdraw_at]
    end
    if @withdraw_collections.save
      flash[:success] = "#{withdraws_number}件、出庫登録しました。"
      redirect_to withdraws_path
    else
      flash[:danger] = "出庫登録に失敗しました。"
      render new_withdraw_path, status: :unprocessable_entity
    end
  end

  def edit
    @paints = Paint.all
  end

  def update
    if @withdraw.update(withdraw_params)
      flash[:success] = "出庫の更新に成功しました。"
      redirect_to withdraws_path(day: @withdraw.withdraw_at)
    else
      flash[:danger] = '更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @withdraw.destroy
    flash[:success] = "#{@withdraw.paint.name}:#{@withdraw.quantity}kgを削除しました。"
    redirect_to withdraws_path(day: @withdraw.withdraw_at)
  end
  
  private
  
    def withdraws_params
      params.require(:withdraws)
    end

    def withdraw_params
      params.require(:withdraw).permit(:withdraw_at, :user_id, :paint_id, :lot_number, :quantity)
    end

    def set_withdraw
      @withdraw = Withdraw.find(params[:id])
    end
end
