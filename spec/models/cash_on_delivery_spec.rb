require 'rails_helper'

RSpec.describe CashOnDelivery, type: :model do
  describe '#validates' do
    it '購入金額0円以上が一つも含まれない場合、バリデーション成功' do
      cash_on_delivery = FactoryBot.build(:cash_on_delivery, cash_on_delivery_details_attributes: [
        { price: 300, more_than: 0 },
        { price: 400, more_than: 10_000 }
      ])
      expect(cash_on_delivery).to be_valid
    end

    it '購入金額0円以上が一つも含まれない場合、バリデーションエラー' do
      cash_on_delivery = FactoryBot.build(:cash_on_delivery, cash_on_delivery_details_attributes: [
        { price: 300, more_than: 1 },
        { price: 400, more_than: 10_000 }
      ])
      expect(cash_on_delivery).not_to be_valid
    end
  end
end
