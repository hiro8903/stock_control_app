class SessionsController < ApplicationController
  def new
    @users = User.order(:name)
  end

  def create
    @users = User.order(:name)
    @user = User.find(params[:session][:id]) unless params[:session][:id].blank?
    if @user && @user.authenticate(params[:session][:password])
      flash[:success] = 'ログインしました。'
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new, status: :unprocessable_entity   #フォームを再表示し、Turboが正常に動作するようにステータスコード422 Unprocessable Entityを返します（unprocessable_entity）
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url, status: :see_other  # ステータスコード303 See Otherでrootパスにリダイレクトします。
  end

  def before_login    
  end
  
  def after_login    
  end
  
end
