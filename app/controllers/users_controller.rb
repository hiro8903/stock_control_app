class UsersController < ApplicationController
  def index
    @users =User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new, status: :unprocessable_entity  #フォームを再表示し、Turboが正常に動作するようにステータスコード422 Unprocessable Entityを返します（unprocessable_entity）
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other # ステータスコード303 See Otherでrootパスにリダイレクトします。
  end
  



  
  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
