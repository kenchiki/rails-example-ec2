Tax.create!(rate: 8)
DeliveryPrice.create!(price: 600, per: 5)

CashOnDelivery.create!(cash_on_delivery_details_attributes: [
  { price: 300, more_than: 0 },
  { price: 400, more_than: 10_000 },
  { price: 600, more_than: 30_000 },
  { price: 1000, more_than: 100_000 }
])

DeliveryTime.create!(delivery_time_details_attributes: [
  { time: '8時〜12時' },
  { time: '12時〜14時' },
  { time: '14時〜16時' },
  { time: '16時〜18時' },
  { time: '18時〜20時' },
  { time: '20時〜21時' }
])
