class Admin::DeliveryPricesController < Admin::AdministratorController
  def new
    @delivery_price = DeliveryPrice.order(id: :desc).first_or_initialize
  end

  def create
    @delivery_price = DeliveryPrice.new(delivery_price_params)

    if @delivery_price.save
      redirect_to new_admin_delivery_price_path, notice: '送料を編集しました。'
    else
      render :new
    end
  end

  private

  def delivery_price_params
    params.require(:delivery_price).permit(:price, :fee)
  end
end
