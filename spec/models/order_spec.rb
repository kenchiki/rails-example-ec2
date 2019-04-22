require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#calc_total_with_tax' do
    before do
      FactoryBot.create(:tax, rate: 8)
      FactoryBot.create(:cash_on_delivery, cash_on_delivery_details_attributes: [
        { price: 300, more_than: 0 },
        { price: 400, more_than: 10_000 },
        { price: 600, more_than: 30_000 },
        { price: 1000, more_than: 100_000 }
      ])
      FactoryBot.create(:delivery_price, price: 600, per: 5)
      FactoryBot.create(:delivery_time, delivery_time_details_attributes: [{ time: '8時〜12時' }])
    end

    it '1,001円の商品が20個の場合、税込み合計は24,645円（税の1円以下は、切り捨て）' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      order = Order.create!(
        delivery_date: '2019-04-15',
        full_name: 'テスト名前',
        post: '000-0000',
        tel: '000-0000-0000',
        address: 'テスト県テスト市テスト町1-1-1',
        delivery_time_detail: DeliveryTimeDetail.order(id: :asc).last,
        user: FactoryBot.create(:user),
        cart: cart
      )

      expect(order.calc_total_with_tax).to eq 24_645
    end
  end
end
