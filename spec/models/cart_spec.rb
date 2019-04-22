require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#self.create_empty' do
    it 'カートを作成してセッション作成する' do
      session = {}
      cart = Cart.create_empty(session)

      expect(cart.class).to be Cart
    end
  end

  describe '#self.session_or_create' do
    it 'セッションが空の場合、カートを作成してセッション作成する' do
      session = {}
      cart = Cart.session_or_create(session)
      expect(cart.class).to be Cart
      expect(session[Cart::SESSION_KEY]).not_to eq nil
    end

    it 'セッションが存在していればカートをセッションから復元する' do
      session = {}
      cart = Cart.session_or_create(session)

      restore_cart = Cart.session_or_create(session)
      expect(cart).to eq restore_cart
    end
  end

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
    end

    it '1,001円の商品が20個の場合、税込み合計は24,645円（税の1円以下は、切り捨て）' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      expect(cart.calc_total_with_tax).to eq 24_645
    end
  end
end
