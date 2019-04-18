FactoryBot.define do
  factory :cart_product do
    cart { FactoryBot.create(:cart) }
    product { FactoryBot.create(:product) }
    quantity { 1 }
  end
end
