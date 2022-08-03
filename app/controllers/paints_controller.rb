class PaintsController < ApplicationController
  before_action :set_paint, only: [:show, :edit, :update, :destroy]
  before_action :set_manufacturers, only: [:new, :create, :edit, :update]

  def index
    @paints = Paint.order(:discontinue).order(:name)
  end

  def show
  end

  def new
    @paint = Paint.new
  end

  def create
    @paint = Paint.new(paint_params)
    if @paint.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @paint
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @paint.update(paint_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @paint
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @paint.destroy
    flash[:success] = "#{@paint.name}を削除しました。"
    redirect_to paints_path, status: :see_other
  end
  

  private
    def paint_params
      params.require(:paint).permit(:name, :manufacturer_id, :unit_price, :ordering_point, :main_ingredient, :warranty, :discontinue)
    end

    # beforeフィルター
    def set_paint
      @paint = Paint.find(params[:id])
    end

    def set_manufacturers
      @manufacturers = Manufacturer.order(:name)
    end
end
