module AllInventoriesHelper

  def each_monthly_inventory(inventory, paint)
    Inventory.all.find_by(inventory_at: @first_day..@last_day, department_id: inventory.department_id, paint_id: paint.id)
  end
  
  def inventory_of_paint(department, paint, monthly_inventory)

    if monthly_inventory.present?
      paint.inventories.find_by(inventory_at: monthly_inventory.inventory_at, department_id: department.id, paint_id: paint.id)
    else
      paint.inventories.find_by(inventory_at: @first_day..@last_day, department_id: department.id, paint_id: paint.id)
    end
  end

  def monthly_inventory(paint)
    AllInventory.find_by(inventory_at: @first_day, paint_id: paint.id)
  end
  
end
