FactoryBot.define do
  factory :shipping_address do
    full_name { 'テスト名前' }
    post { '111-1111' }
    tel { '111-1111-1111' }
    address { 'テスト県テスト市テスト町1-1-1' }
    user { FactoryBot.create(:user) }
  end
end
