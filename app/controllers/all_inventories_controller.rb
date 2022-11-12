class AllInventoriesController < ApplicationController
  before_action :set_day, only: [:index, :new]

  def index
    # 仮設定
    @day = Date.current
    @all_monthly_inventories = AllInventory.all
  end

  def new
    @day = Date.current
    @paints = Paint.all
    @departments = Department.all
    @all_monthly_inventory = AllInventory.new
    @each_monthly_inventories = Inventory.all.where(inventory_at: @first_day..@last_day).includes(:paint).order("paints.name ASC")
  end
  

  def create
    
  end

  def update
    
  end
  
  def destroy
    
  end
  
  
end
