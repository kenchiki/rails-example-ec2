FactoryBot.define do
  factory :order_detail do
    price { 1 }
    quantity { 1 }
    order { nil }
    product { nil }
  end
end
