require 'rails_helper'

describe 'my/shipping_addresses', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe '#new' do
    it '既に登録されている配送情報がフォームに初期値として反映されている' do
      user.shipping_addresses << FactoryBot.build(
        :shipping_address,
        full_name: 'テスト名前2',
        post: '222-2222',
        tel: '333-3333-3333',
        address: 'テスト県テスト市テスト町2-2-2'
      )

      visit new_my_shipping_address_path

      expect(page).to have_field 'shipping_address[full_name]', with: 'テスト名前2'
      expect(page).to have_field 'shipping_address[post]', with: '222-2222'
      expect(page).to have_field 'shipping_address[tel]', with: '333-3333-3333'
      expect(page).to have_field 'shipping_address[address]', with: 'テスト県テスト市テスト町2-2-2'
    end
  end

  describe '#create' do
    it '配送情報を新規追加できる' do
      visit new_my_shipping_address_path

      find_field('shipping_address[full_name]').set('テスト名前2')
      find_field('shipping_address[post]').set('222-2222')
      find_field('shipping_address[tel]').set('333-3333-3333')
      find_field('shipping_address[address]').set('テスト県テスト市テスト町2-2-2')
      click_on('登録する')

      expect(find('#flash')).to have_content '配送情報を編集しました'

      last_shipping_address = user.last_shipping_address
      expect(last_shipping_address.full_name).to eq 'テスト名前2'
      expect(last_shipping_address.post).to eq '222-2222'
      expect(last_shipping_address.tel).to eq '333-3333-3333'
      expect(last_shipping_address.address).to eq 'テスト県テスト市テスト町2-2-2'
    end
  end
end
