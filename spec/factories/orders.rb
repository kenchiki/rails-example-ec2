FactoryBot.define do
  factory :order do
    delivery_time { "MyString" }
    delivery_date { "2019-04-15" }
    post { "MyString" }
    tel { "MyString" }
    address { "MyString" }
    cash_on_delivery { 1 }
    delivery_price { 1 }
    tax_price { 1 }
    total_without_tax { 1 }
    total_with_tax { 1 }
    cash_on_delivery { nil }
    delivery_price { nil }
    tax { nil }
  end
end
