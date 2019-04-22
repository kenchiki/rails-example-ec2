require 'rails_helper'

describe 'my/orders', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user

    user.shipping_addresses << FactoryBot.build(
      :shipping_address,
      full_name: 'テスト名前2',
      post: '222-2222',
      tel: '333-3333-3333',
      address: 'テスト県テスト市テスト町2-2-2'
    )
  end

  describe '#index' do
    it '注文一覧に自分の注文のみが表示される' do
      my_order = FactoryBot.create(:order, user: user)
      other_user_order = FactoryBot.create(:order, user: FactoryBot.create(:user, :with_deliver_info))

      visit my_orders_path
      table = find(:test, 'orders__index')
      expect(table).to have_link '注文詳細', href: my_order_path(my_order)
      expect(table).to have_no_link '注文詳細', href: my_order_path(other_user_order)
    end
  end

  describe '#show' do
    include_context :show_exceptions

    it '自分の注文詳細のみが表示できる' do
      my_order = FactoryBot.create(:order, user: user)

      visit my_order_path(my_order)

      expect(page).to have_selector 'h1', text: '注文詳細'

      table = find(:test, 'orders__show')
      expect(table).to have_content 'テスト名前2'
      expect(table).to have_content '222-2222'
      expect(table).to have_content '333-3333-3333'
      expect(table).to have_content 'テスト県テスト市テスト町2-2-2'
    end

    it '他のユーザーの注文詳細は表示できない' do
      other_user_order = FactoryBot.create(:order, user: FactoryBot.create(:user, :with_deliver_info))

      visit my_order_path(other_user_order)

      expect(page).to have_selector 'h1', text: "The page you were looking for doesn't exist."
    end
  end
end
