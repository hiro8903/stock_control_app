class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_user
    @user = current_user
  end
  

  def set_department_monthly_inventory
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @department_monthly_inventory = Inventory.all.where(inventory_at: @first_day..@last_day, department_id: @user.department_id) if @user.department_id.present?
  end

end
