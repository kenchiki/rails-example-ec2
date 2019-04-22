require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#validates' do
    it '配送時間の入力が1つ以上ある場合、バリデーション成功' do
      delivery_time = FactoryBot.build(:delivery_time, delivery_time_details_attributes: [{ time: '8時〜12時' }])

      expect(delivery_time).to be_valid
    end

    it '配送時間の入力がない場合、バリデーションエラー' do
      delivery_time = FactoryBot.build(:delivery_time, delivery_time_details_attributes: [])

      expect(delivery_time).not_to be_valid
    end
  end
end
