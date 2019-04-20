class My::OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :require_delivery_info, only: %i[new create]

  def index
    @orders = current_user.orders.order(id: :desc).page(params[:page])
  end

  def show
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.cart = current_cart

    if @order.save
      new_cart
      redirect_to [:my, @order], notice: '注文が完了しました'
    else
      render :new
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:delivery_date, :delivery_time_detail_id)
  end

  def require_delivery_info
    unless current_user.last_shipping_address
      redirect_to new_my_shipping_address_path, alert: '配送情報を入力してください'
    end
  end
end
