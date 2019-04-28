require 'rails_helper'

describe 'admin/orders', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
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

    it '一覧に全ユーザーの注文が表示される' do
      order = FactoryBot.create(
        :order, user: FactoryBot.create(:user, :with_delivery_info), delivery_date: '2018-01-03'
      )
      order2 = FactoryBot.create(
        :order, user: FactoryBot.create(:user, :with_delivery_info), delivery_date: '2018-01-03'
      )

      visit admin_orders_path
      table = find(:test, 'orders__index')
      expect(table).to have_link '注文詳細', href: admin_order_path(order)
      expect(table).to have_link '注文詳細', href: admin_order_path(order2)
    end
  end
end
