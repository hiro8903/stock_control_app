module AllInventoriesHelper

  def each_monthly_inventory(inventory, paint)
    Inventory.all.find_by(inventory_at: @first_day..@last_day, department_id: inventory.department_id, paint_id: paint.id)
  end
  
  def inventory_of_paint(department, paint)
    paint.inventories.find_by(inventory_at: @first_day..@last_day, department_id: department.id, paint_id: paint.id)
  end
  
end
