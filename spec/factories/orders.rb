FactoryBot.define do
  factory :order do
    delivery_date { '2019-04-15' }
    full_name { 'テスト名前' }
    post { '000-0000' }
    tel { '000-0000-0000' }
    address { 'テスト県テスト市テスト町1-1-1' }
    total_with_tax { 1000 }
    cash_on_delivery { FactoryBot.create(:cash_on_delivery) }
    delivery_price { FactoryBot.create(:delivery_price) }
    tax { FactoryBot.create(:tax) }
    user { FactoryBot.create(:user) }
    delivery_time_detail { FactoryBot.create(:delivery_time).delivery_time_details.first }
    cart { FactoryBot.create(:cart) }
  end
end
