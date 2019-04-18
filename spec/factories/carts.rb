FactoryBot.define do
  factory :cart do
    trait :with_product do
      after(:build) do |cart|
        cart.cart_products << FactoryBot.build(:cart_product)
      end
    end
  end
end
