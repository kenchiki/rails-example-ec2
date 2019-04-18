class Admin::OrdersController < Admin::AdministratorController
  def index
    @orders = Order.order(id: :desc).page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end
end
