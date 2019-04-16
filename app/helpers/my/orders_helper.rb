module My::OrdersHelper
  def delivery_time_details
    delivery_time = DeliveryTime.order(id: :asc).last
    delivery_time.delivery_time_details.map do |delivery_time_detail|
      [delivery_time_detail.time, delivery_time_detail.id]
    end
  end

  def delivery_dates
    delivery_dates = DeliveryDateCalculation.new.dates
    delivery_dates.map do |delivery_date|
      [I18n.l(delivery_date.to_time, format: :date), delivery_date]
    end
  end
end
