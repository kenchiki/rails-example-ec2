require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#last_shipping_address' do
    it '最後に登録された配送情報を返す' do
      user = FactoryBot.create(:user)

      user.shipping_addresses << FactoryBot.build(
        :shipping_address,
        full_name: 'テスト名前2',
        post: '222-2222',
        tel: '333-3333-3333',
        address: 'テスト県テスト市テスト町2-2-2'
      )

      user.shipping_addresses << FactoryBot.build(
        :shipping_address,
        full_name: 'テスト名前3',
        post: '333-3333',
        tel: '444-4444-4444',
        address: 'テスト県テスト市テスト町3-3-3'
      )

      shipping_address = user.last_shipping_address

      expect(shipping_address.full_name).to eq 'テスト名前3'
      expect(shipping_address.post).to eq '333-3333'
      expect(shipping_address.tel).to eq '444-4444-4444'
      expect(shipping_address.address).to eq 'テスト県テスト市テスト町3-3-3'
    end
  end
end
