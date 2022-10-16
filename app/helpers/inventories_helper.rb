module InventoriesHelper

  def month_inventory(inventories, year, month)
    @inventories = Inventory.where(department_id: current_user.department.id)
    
  end
  
end
