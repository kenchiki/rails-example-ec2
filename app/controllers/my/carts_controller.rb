class My::CartsController < ApplicationController
  before_action :set_cart, only: %i[edit update]

  def edit
  end

  def update
    if @cart.update(cart_params)
      redirect_to gateways_my_orders_url
    else
      render :edit
    end
  end

  private

  def set_cart
    @cart = current_cart
  end

  def cart_params
    params.require(:cart).permit(:delivery_date, :delivery_time_detail_id)
  end
end
