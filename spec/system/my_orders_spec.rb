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
    around do |it|
      travel_to(Time.zone.local(2018, 1, 1, 0, 0, 0)) do
        it.run
      end
    end

    before do
      FactoryBot.create(:tax)
      FactoryBot.create(:cash_on_delivery)
      FactoryBot.create(:delivery_price)
    end

    it '注文一覧に自分の注文のみが表示される' do
      my_order = FactoryBot.create(:order, user: user, delivery_date: '2018-01-03')
      other_user_order = FactoryBot.create(
        :order, user: FactoryBot.create(:user, :with_delivery_info), delivery_date: '2018-01-03'
      )

      visit my_orders_path
      table = find(:test, 'orders__index')
      expect(table).to have_link '注文詳細', href: my_order_path(my_order)
      expect(table).to have_no_link '注文詳細', href: my_order_path(other_user_order)
    end
  end

  describe '#show' do
    include_context :show_exceptions

    around do |it|
      travel_to(Time.zone.local(2018, 1, 1, 0, 0, 0)) do
        it.run
      end
    end

    before do
      FactoryBot.create(:tax)
      FactoryBot.create(:cash_on_delivery)
      FactoryBot.create(:delivery_price)
    end

    it '自分の注文詳細のみが表示できる' do
      order = FactoryBot.create(:order, user: user, delivery_date: '2018-01-03')

      visit my_order_path(order)

      expect(page).to have_selector 'h1', text: '注文詳細'

      target = find(:test, 'orders__show')
      expect(target).to have_content 'テスト名前2'
      expect(target).to have_content '222-2222'
      expect(target).to have_content '333-3333-3333'
      expect(target).to have_content 'テスト県テスト市テスト町2-2-2'
    end

    it '他のユーザーの注文詳細は表示できない' do
      other_user_order = FactoryBot.create(
        :order, user: FactoryBot.create(:user, :with_delivery_info), delivery_date: '2018-01-03'
      )

      visit my_order_path(other_user_order)

      expect(page).to have_selector 'h1', text: "The page you were looking for doesn't exist."
    end

    it '注文後、配送情報を変更しても配送情報は注文確定時のものが適用されている' do
      order = FactoryBot.create(:order, user: user, delivery_date: '2018-01-03')
      user.shipping_addresses.create!(full_name: 'テスト名前3',
                                      post: '444-4444',
                                      tel: '555-5555-5555',
                                      address: 'テスト県テスト市テスト町3-3-3')

      visit my_order_path(order)

      expect(page).to have_selector 'h1', text: '注文詳細'

      target = find(:test, 'orders__show')
      expect(target).to have_content 'テスト名前2'
      expect(target).to have_content '222-2222'
      expect(target).to have_content '333-3333-3333'
      expect(target).to have_content 'テスト県テスト市テスト町2-2-2'
    end
  end
end
