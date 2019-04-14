class Admin::UsersController < Admin::AdministratorController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to [:admin, @user], notice: 'ユーザーを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_url, notice: 'ユーザーを削除しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :post, :tel, :address)
  end
end
