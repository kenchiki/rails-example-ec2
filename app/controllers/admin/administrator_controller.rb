class Admin::AdministratorController < ApplicationController
  before_action :require_administrator

  private

  def require_administrator
    redirect_to root_path, alert: '権限がありません' unless current_user.admin?
  end
end
