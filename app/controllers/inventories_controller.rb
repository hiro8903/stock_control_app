class InventoriesController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update]
  before_action :set_day, only: [:index]
  before_action :set_department_monthly_inventoies, only: [:index]


  def index
    @day = Date.current
    @inventories = Inventory.where(department_id: current_user.department.id) if Inventory.count > 0
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @users = User.all
    @paints = Paint.all
    @inventory = Inventory.new
    # 棚卸まとめの編集ページから来た場合、数量登録の無い品番へ部署・棚卸日・塗料のデータを入れる。
    if params["department"].present? && params["inventory_at"].present? && params["paint"]
      @inventory["department_id"] = params["department"]
      @inventory["inventory_at"] = params["inventory_at"]
      @inventory["paint_id"] = params["paint"]
    end
    session[:previous_url] = request.referer  # ここで前ページセッションを保存
  end

  def create
    @users = User.all
    @paints = Paint.all
    @inventory = Inventory.new(inventories_params)
    params["inventory"]["inventory_at"]  << "-1" 
    if @inventory.save
      flash[:success] = '棚卸し登録しました。'
      redirect_to session[:previous_url]  # create後に遷移させる
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
    @paints = Paint.all
    @inventory = Inventory.find(params[:id])
    @before_quantity = @inventory.quantity
    params["inventory"]["inventory_at"]  << "-1" 
    if @inventory.update(inventories_params)
      flash[:success] = "#{@inventory.department.name}の棚卸を更新しました。<br>
      #{@inventory.paint.name}：#{@before_quantity} ➡︎ #{@inventory.quantity}"
      if params[:action] == "new"
        redirect_to inventories_path
      else
        redirect_to edit_all_inventory_path(inventory_at: @first_day)
      end
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
