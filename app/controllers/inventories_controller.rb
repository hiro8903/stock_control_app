class InventoriesController < ApplicationController
  def index
    @day = Date.current
    @this_year = @day.year
    @this_month = @day.month
    @prev_month = @day.prev_month
    @prev_year = @prev_month.year
    @prev_month = @prev_month.month
    @inventories = Inventory.where(department_id: current_user.department.id)
    @departments = Department.all.order(name: :asc)
    @paints = Paint.all.order(name: :asc)

  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @users = User.all
    @paints = Paint.all
    @inventory = Inventory.new
  end

  def create
    @users = User.all
    @paints = Paint.all
    @inventory = Inventory.new(inventories_params)
    if @inventory.save
      flash[:success] = '棚卸し登録しました。'
      redirect_to inventories_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @users = User.all
    @paints = Paint.all
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update(inventories_params)
      flash[:success] = '更新に成功しました。'
      redirect_to inventories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    flash[:success] = "削除しました。"
    redirect_to inventories_path
  end

  private
    def inventories_params
      params.require(:inventory).permit(:user_id, :editor_id, :department_id, :inventory_at, :paint_id, :quantity)
    end
end