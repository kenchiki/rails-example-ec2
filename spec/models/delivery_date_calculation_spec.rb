require 'rails_helper'

RSpec.describe DeliveryDateCalculation do
  describe '#dates' do
    around do |it|
      travel_to(Time.zone.local(2018, 1, 1, 0, 0, 0)) do
        it.run
      end
    end

    # 2018/1の営業日メモ
    # 1(月) 2(火) 3(水) 4(木) 5(金) 8(月) 9(火) 10(水) 11(木) 12(金) 15(月) 16(火) 17(水) 18(木) 19(金) 22(月) 23(火) 〜
    it '2018/1/1に注文する場合、配送日を3営業日（営業日: 月-金）から14営業日まで指定できる' do
      delivery_dates = DeliveryDateCalculation.new.dates

      business_dates = [Date.new(2018, 1, 3), Date.new(2018, 1, 4), Date.new(2018, 1, 5), Date.new(2018, 1, 8),
                        Date.new(2018, 1, 9), Date.new(2018, 1, 10), Date.new(2018, 1, 11), Date.new(2018, 1, 12),
                        Date.new(2018, 1, 15), Date.new(2018, 1, 16), Date.new(2018, 1, 17), Date.new(2018, 1, 18)]

      expect(business_dates.all? { |business_date| delivery_dates.include?(business_date) }).to be_truthy
      expect(delivery_dates.size).to eq 12
    end
  end
end
