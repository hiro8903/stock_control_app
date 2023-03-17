class StocksController < ApplicationController
  before_action :set_day, only: [:index]

  def index
    @paints = Paint.all
    @day = Date.current
    @last_month = @first_day.prev_month
    @beginning_stocks = AllInventory.where(inventory_at: @last_month)
  end

  def show
  end
end
