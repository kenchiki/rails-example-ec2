class My::ShippingAddressesController < ApplicationController
  def new
    @shipping_address = current_user.shipping_addresses.order(id: :desc).first_or_initialize
  end

  def create
    @shipping_address = current_user.shipping_addresses.build(shipping_address_params)

    if @shipping_address.save
      redirect_to new_my_shipping_address_path, notice: '配送情報を編集しました'
    else
      render :new
    end
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:full_name, :post, :tel, :address)
  end
end
