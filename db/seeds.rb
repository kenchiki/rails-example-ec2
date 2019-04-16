Tax.create!(rate: 8)
DeliveryPrice.create!(price: 600, per: 5)
CashOnDelivery.create!.tap do |cash_on_delivery|
  cash_on_delivery.cash_on_delivery_details.create!(price: 300, more_than: 0)
  cash_on_delivery.cash_on_delivery_details.create!(price: 400, more_than: 10_000)
  cash_on_delivery.cash_on_delivery_details.create!(price: 600, more_than: 30_000)
  cash_on_delivery.cash_on_delivery_details.create!(price: 1000, more_than: 100_000)
end
DeliveryTime.create!.tap do |delivery_time|
  delivery_time.delivery_time_details.create!(time: '8時〜12時')
  delivery_time.delivery_time_details.create!(time: '12時〜14時')
  delivery_time.delivery_time_details.create!(time: '14時〜16時')
  delivery_time.delivery_time_details.create!(time: '16時〜18時')
  delivery_time.delivery_time_details.create!(time: '18時〜20時')
  delivery_time.delivery_time_details.create!(time: '20時〜21時')
end
