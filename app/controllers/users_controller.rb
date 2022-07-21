class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users =User.all
  end

  def show
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
  end

  def update
    if @user.update(user_params)
      log_in @user
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

    # beforeフィルター

    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to root_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      flash[:danger] = "権限がありません。"
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
