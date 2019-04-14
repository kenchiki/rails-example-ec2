class Admin::CashOnDeliveriesController < Admin::AdministratorController
  def new
    @cash_on_delivery = CashOnDelivery.order(id: :desc).first_or_initialize
  end

  def create
    @cash_on_delivery = CashOnDelivery.new(cash_on_delivery_params)

    if @cash_on_delivery.save
      redirect_to new_admin_cash_on_delivery_path, notice: '代引き手数料を編集しました。'
    else
      render :new
    end
  end

  private

  def cash_on_delivery_params
    params.require(:cash_on_delivery).permit(cash_on_delivery_details_attributes: %i[price more_than])
  end
end
