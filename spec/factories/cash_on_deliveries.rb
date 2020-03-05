FactoryBot.define do
  factory :cash_on_delivery do
    cash_on_delivery_details_attributes [
                                          { price: 300, more_than: 0 },
                                          { price: 400, more_than: 10000 },
                                          { price: 600, more_than: 30000 },
                                          { price: 1000, more_than: 100000 }
                                        ]
  end
end
