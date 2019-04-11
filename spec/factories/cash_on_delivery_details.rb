FactoryBot.define do
  factory :cash_on_delivery_detail do
    price { 1 }
    more_than { 1 }
    cash_on_delivery { nil }
  end
end
