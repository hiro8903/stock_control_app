class WithdrawsController < ApplicationController
  before_action :set_user, only: [:new]
  def index
  end

  def show
  end

  def new
    @paints = Paint.all
    @withdraw_collections = Form::WithdrawCollection.new
  end

  def edit
  end
end
