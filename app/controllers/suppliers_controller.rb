class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  def index
    @suppliers = Supplier.order(:name)
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end
  
  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @supplier
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @supplier.update(supplier_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @supplier
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @supplier.destroy
    flash[:success] = "#{@supplier.name}を削除しました。"
    redirect_to suppliers_path, status: :see_other
  end

  private
    def supplier_params
      params.require(:supplier).permit(:name)
    end
    
    # paramsハッシュから仕入先を取得する。
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end
    
  
end
