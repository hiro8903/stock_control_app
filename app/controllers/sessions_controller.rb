class SessionsController < ApplicationController
  def new
    @users = User.order(:name)
  end
end
