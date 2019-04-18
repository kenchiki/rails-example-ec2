class Admin::DeliveryTimesController < Admin::AdministratorController

  def new
    @delivery_time = DeliveryTime.order(id: :desc).first_or_initialize
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)

    if @delivery_time.save
      redirect_to new_admin_delivery_time_path, notice: '配送希望時間を編集しました'
    else
      render :new
    end
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(delivery_time_details_attributes: %i[time _destroy])
  end
end
