class Admin::AdministratorController < ApplicationController
  before_action :require_administrator

  def require_administrator
    redirect_to root_path unless current_user.admin?
  end
end
