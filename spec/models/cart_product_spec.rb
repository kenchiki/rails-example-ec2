require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }

  before do
    FactoryBot.create(:cart_product, product: product, cart: cart, quantity: 1)
  end

  describe '#sum_quantity' do
    it '既にカートに入っている同じ商品に数量が足される' do
      cart_product = FactoryBot.create(:cart_product, product: product, cart: cart, quantity: 1)

      expect(cart_product.quantity).to eq 2
    end
  end

  describe '#adjust_quantity' do
    it 'CartProduct::MAX_QUANTITYを超える数量は自動で調整される' do
      cart_product = FactoryBot.create(:cart_product, product: product, cart: cart, quantity: 20)

      expect(cart_product.quantity).to eq 20
    end
  end
end
