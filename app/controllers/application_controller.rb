class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_user
    @user = current_user
  end
  
  def set_day
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
  end
  
  def set_department_monthly_inventoies
    @department_monthly_inventoies = Inventory.all.where(inventory_at: @first_day..@last_day, department_id: @user.department_id).includes(:paint).order("paints.name ASC") if @user.department_id.present?
  end

end
