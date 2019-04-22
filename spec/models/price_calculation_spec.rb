require 'rails_helper'

RSpec.describe PriceCalculation do
  let(:tax) { FactoryBot.create(:tax, rate: 8) }
  let(:cash_on_delivery) {
    FactoryBot.create(:cash_on_delivery, cash_on_delivery_details_attributes: [
      { price: 300, more_than: 0 },
      { price: 400, more_than: 10_000 },
      { price: 600, more_than: 30_000 },
      { price: 1000, more_than: 100_000 }
    ])
  }
  let(:delivery_price) { FactoryBot.create(:delivery_price, price: 600, per: 5) }

  describe '#products_quantity' do
    it '1,000円の商品が13個と500円の商品が16個の場合、商品の合計個数は29個' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 13, product: FactoryBot.create(:product, price: 1000)
      )
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 16, product: FactoryBot.create(:product, price: 500)
      )

      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.products_quantity).to eq 29
    end
  end

  describe '#products_price' do
    it '1,000円の商品が13個と500円の商品が16個の場合、商品の小計が21,000円' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 13, product: FactoryBot.create(:product, price: 1000)
      )
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 16, product: FactoryBot.create(:product, price: 500)
      )

      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.products_price).to eq 21_000
    end
  end

  describe '#delivery_price' do
    let(:cart) { FactoryBot.create(:cart) }

    it '商品が5個の場合、送料は600円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 5, product: FactoryBot.create(:product, price: 1000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.delivery_price).to eq 600
    end

    it '商品が6個の場合、送料は1,200円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 6, product: FactoryBot.create(:product, price: 1000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.delivery_price).to eq 1200
    end

    it '商品が10個の場合、送料は1,200円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 10, product: FactoryBot.create(:product, price: 1000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.delivery_price).to eq 1200
    end

    it '商品が11個の場合、送料は1,800円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 11, product: FactoryBot.create(:product, price: 1000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.delivery_price).to eq 1800
    end
  end

  describe '#cash_on_delivery' do
    let(:cart) { FactoryBot.create(:cart) }

    it '商品の小計が9,999円の場合、代引き手数料は300円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 1, product: FactoryBot.create(:product, price: 9999)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.cash_on_delivery).to eq 300
    end

    it '商品の小計が10,000円の場合、代引き手数料は400円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 1, product: FactoryBot.create(:product, price: 10_000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.cash_on_delivery).to eq 400
    end

    it '商品の小計が99,999円の場合、代引き手数料は600円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 1, product: FactoryBot.create(:product, price: 99_999)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.cash_on_delivery).to eq 600
    end

    it '商品の小計が100,000円の場合、代引き手数料は1,000円' do
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 1, product: FactoryBot.create(:product, price: 100_000)
      )
      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.cash_on_delivery).to eq 1000
    end
  end

  describe '#total_without_tax' do
    it '1,001円の商品が20個の場合、税抜き合計は22,820円' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.total_without_tax).to eq 22_820
    end
  end

  describe '#tax_price' do
    it '1,001円の商品が20個の場合、消費税は1,601円（税の1円以下は、切り捨て）' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.tax_price).to eq 1825
    end
  end

  describe '#total_with_tax' do
    it '1,001円の商品が20個の場合、税込み合計は24,645円（税の1円以下は、切り捨て）' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      price_calculation = PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart.cart_products)

      expect(price_calculation.total_with_tax).to eq 24_645
    end
  end
end
