class Admin::UsersController < ApplicationController
  before_action :not_admin
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
    flash[:notice] = "ユーザーを削除しました"
  end

  private

  def not_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:notice] = "管理者以外アクセスできません"
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
