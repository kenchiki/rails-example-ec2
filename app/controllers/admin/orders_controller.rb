class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.order(id: :desc).page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end
end
