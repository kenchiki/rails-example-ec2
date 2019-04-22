require 'rails_helper'

RSpec.describe CashOnDeliveryDetail, type: :model do
  describe '#self.find_by_products_price!' do
    let(:cash_on_delivery) {
      FactoryBot.create(:cash_on_delivery, cash_on_delivery_details_attributes: [
        { price: 300, more_than: 0 },
        { price: 400, more_than: 10_000 },
        { price: 600, more_than: 30_000 },
        { price: 1000, more_than: 100_000 }
      ])
    }

    it '商品購入金額が1円の場合、代引き手数料300円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(1).price).to eq 300
    end

    it '商品購入金額が9,999円の場合、代引き手数料300円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(9_999).price).to eq 300
    end

    it '商品購入金額が10,000円の場合、代引き手数料400円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(10_000).price).to eq 400
    end

    it '商品購入金額が29,999円の場合、代引き手数料400円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(29_999).price).to eq 400
    end

    it '商品購入金額が30,000円の場合、代引き手数料600円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(30_000).price).to eq 600
    end

    it '商品購入金額が99,999円の場合、代引き手数料600円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(99_999).price).to eq 600
    end

    it '商品購入金額が100,000円の場合、代引き手数料1,000円を返す' do
      expect(cash_on_delivery.cash_on_delivery_details.find_by_products_price!(100_000).price).to eq 1000
    end
  end
end
