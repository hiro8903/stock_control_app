class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers = Manufacturer.order(:name)
  end

  def show
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @manufacturer
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @manufacturer.update(manufacturer_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @manufacturer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @manufacturer.destroy
    flash[:success] = "#{@manufacturer.name}を削除しました。"
    redirect_to manufacturers_path, status: :see_other
  end
  
  private
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end


    # paramsハッシュからユーザーを取得します。
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end
    
end
