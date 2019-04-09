FactoryBot.define do
  factory :product do
    name { "MyString" }
    image { "MyString" }
    price { 1 }
    description { "MyText" }
    published { false }
    position { 1 }
  end
end
