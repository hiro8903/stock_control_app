class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def index
    @departments = Department.order(:name)
  end
  
  def show
  end
  
  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @department
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  
  def update
    if @department.update(department_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @department
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @department.destroy
    flash[:success] = "#{@department.name}を削除しました。"
    redirect_to departments_path, status: :see_other
  end

  private
    def department_params
      params.require(:department).permit(:name)
    end
    
    # beforeフィルター

    # paramsハッシュからdepartment(部署)を取得します。
    def set_department
      @department = Department.find(params[:id])
    end
end
