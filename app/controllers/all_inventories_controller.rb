class AllInventoriesController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_day, only: [:index, :new, :edit, :create]

  def index
    # 仮設定
    @paints = Paint.all
    @departments = Department.all
    @day = Date.current
    @all_monthly_inventories = AllInventory.where(inventory_at: @first_day)
  end

  def new
    @all_inventory = AllInventory.new
    @day = Date.current
    @paints = Paint.all
    @departments = Department.all
    @all_inventory_collections = Form::AllInventoryCollection.new
    # 各班の指定の年月の棚卸結果
    @each_monthly_inventories = Inventory.where(inventory_at: @first_day..@last_day).includes(:paint).order("paints.name ASC")
  end
  

  def create
    @paints = Paint.all
    @departments = Department.all
    @all_monthly_inventories = AllInventory.where(inventory_at: @first_day)
    @all_inventory_collections = Form::AllInventoryCollection.new(all_monthly_inventories_params)
    if @all_inventory_collections.save
      redirect_to all_inventories_url(date: params[:date])
    else
      params[:all_inventories].first["inventory_at"].to_date > Date.current ? flash[:danger] = "本日より先の日付けの棚卸は確定できません。" : flash[:danger] = "失敗しました。"
      @all_inventory_collections = Form::AllInventoryCollection.new # render時に表が複数発生してしまう不具合を防止するため。
      if params[:all_inventories].first["inventory_at"].to_date > Date.current
        redirect_to all_inventories_url(date: params[:date])
      else
        render new_all_inventory_path, status: :unprocessable_entity
      end
    end
  end

  def edit
    @all_inventory = AllInventory.find(params[:id])

    # @day = Date.current
    @paints = Paint.all
    @departments = Department.all
    @all_inventory_collections = AllInventory.where(inventory_at: @all_inventory.inventory_at)
    # debugger
    # 各班の指定の年月の棚卸結果
    # @each_monthly_inventories = Inventory.where(inventory_at: @all_inventory.inventory_at).includes(:paint).order("paints.name ASC")
  end

  # def update
  #   @paints = Paint.all
  #   @departments = Department.all
  #   # debugger
  #   @all_inventory_collections = Form::AllInventoryCollection.update_all(all_monthly_inventories_params)
  #   # debugger
  #   if @all_inventory_collections.save
  #     redirect_to all_inventories_url(date: params[:date])
  #   else
  #     params[:all_inventories].first["inventory_at"].to_date > Date.current ? flash[:danger] = "本日より先の日付けの棚卸は確定できません。" : flash[:danger] = "失敗しました。"
  #     @all_inventory_collections = Form::AllInventoryCollection.new # render時に表が複数発生してしまう不具合を防止するため。
  #     if params[:all_inventories].first["inventory_at"].to_date > Date.current
  #       redirect_to all_inventories_url(date: params[:date])
  #     else
  #       render new_all_inventory_path, status: :unprocessable_entity
  #     end
  #   end
  # end

  def update

      ActiveRecord::Base.transaction do # トランザクションを開始します。
        all_monthly_inventories_params.each do |id, item|
          
          @all_monthly_inventory = AllInventory.find(id)
          @all_monthly_inventory.update!(paint_id: "#{@all_monthly_inventory.paint_id}")
          @all_monthly_inventory.update!(inventory_at: "#{@all_monthly_inventory.inventory_at}")
          @all_monthly_inventory.update!(quantity: "#{@all_monthly_inventory.quantity}")
          @all_monthly_inventory.save
        end
        flash[:success] = "まとめて更新しました。"
        redirect_to all_inventories_url(date: params[:date])
      end
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
        if @all_monthly_inventory.errors.any?
          @all_monthly_inventory.errors.full_messages.each do |msg| 
          flash[:danger] = "#{msg}"
          end 
        end
      redirect_to edit_all_inventory_url(date: params[:date])
  end
  
  def destroy
    
  end
  
  private

    def all_monthly_inventories_params
      params.require(:all_inventories)
    end
  
    def all_monthly_inventories_edit_params
      params.require(:all_inventory).permit(:paint_id, :inventory_at, :quantity)
    end

end
