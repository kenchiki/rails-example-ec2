Tax.create!(rate: 8)
DeliveryPrice.create!(price: 600, fee: 5)
CashOnDelivery.create!.tap do |cash_on_delivery|
  cash_on_delivery.cash_on_delivery_details.create!(price: 300, more_than: 0)
  cash_on_delivery.cash_on_delivery_details.create!(price: 400, more_than: 10_000)
  cash_on_delivery.cash_on_delivery_details.create!(price: 600, more_than: 30_000)
  cash_on_delivery.cash_on_delivery_details.create!(price: 1000, more_than: 100_000)
end
