class My::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_my_user_path, notice: '配送情報を編集しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :post, :tel, :address)
  end
end
