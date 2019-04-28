FactoryBot.define do
  factory :order do
    delivery_date { '2019-05-01' }
    total_with_tax { 1000 }
    user { FactoryBot.create(:user, :with_delivery_info) }
    delivery_time_detail { FactoryBot.create(:delivery_time).delivery_time_details.first }
    cart { FactoryBot.create(:cart) }
  end
end
