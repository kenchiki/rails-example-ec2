require 'rails_helper'

RSpec.describe Order, type: :model do

  describe '#validates' do
    before do
      FactoryBot.create(:tax)
      FactoryBot.create(:cash_on_delivery)
      FactoryBot.create(:delivery_price)
    end

    around do |it|
      travel_to(Time.zone.local(2018, 1, 1, 0, 0, 0)) do
        it.run
      end
    end

    it '2018/1/1に注文する場合、配送日を2営業日に指定するとバリデーションエラー' do
      order = FactoryBot.build(:order, delivery_date: '2018-01-02')

      expect(order).not_to be_valid
    end

    it '2018/1/1に注文する場合、配送日を3営業日に指定するとバリデーション成功' do
      order = FactoryBot.build(:order, delivery_date: '2018-01-03')

      expect(order).to be_valid
    end

    it '2018/1/1に注文する場合、配送日を14営業日に指定するとバリデーション成功' do
      order = FactoryBot.build(:order, delivery_date: '2018-01-18')

      expect(order).to be_valid
    end

    it '2018/1/1に注文する場合、配送日を14営業日に指定するとバリデーションエラー' do
      order = FactoryBot.build(:order, delivery_date: '2018-01-19')

      expect(order).not_to be_valid
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
      FactoryBot.create(:delivery_time, delivery_time_details_attributes: [{ time: '8時〜12時' }])
    end

    around do |it|
      travel_to(Time.zone.local(2018, 1, 1, 0, 0, 0)) do
        it.run
      end
    end

    it '1,001円の商品が20個の場合、税込み合計は24,645円（税の1円以下は、切り捨て）' do
      cart = FactoryBot.create(:cart)
      cart.cart_products << FactoryBot.create(
        :cart_product, quantity: 20, product: FactoryBot.create(:product, price: 1001)
      )

      user = FactoryBot.create(:user, :with_delivery_info)

      order = Order.create!(
        delivery_date: '2018-01-03',
        delivery_time_detail: DeliveryTimeDetail.order(id: :asc).last,
        user: user,
        cart: cart
      )

      expect(order.calc_total_with_tax).to eq 24_645
    end
  end

  describe '#sent_mail' do
    include ActionView::Helpers::NumberHelper
    include ApplicationHelper

    before do
      FactoryBot.create(:tax)
      FactoryBot.create(:cash_on_delivery)
      FactoryBot.create(:delivery_price)
    end

    it '注文すると管理者と購入者へメールが送信される' do

      FactoryBot.create(:user, :with_admin, email: 'admin@example.com')

      user = FactoryBot.create(:user, email: 'user@example.com')
      user.shipping_addresses.create(full_name: 'テスト名前',
                                     post: '111-1111',
                                     tel: '222-2222-2222',
                                     address: 'テスト県テスト市テスト町1-1-1')

      perform_enqueued_jobs do
        order = FactoryBot.create(:order, user: user)
        sent_mails = ActionMailer::Base.deliveries.last(2)

        user_sent_mail = sent_mails[0]
        expect(user_sent_mail.subject).to eq '【さくらマーケット】ご注文ありがとうございます'
        expect(user_sent_mail.to.first).to eq 'user@example.com'
        expect(user_sent_mail.from.first).to eq 'from@example.com'

        expect(user_sent_mail.body.raw_source).to include 'テスト名前'
        expect(user_sent_mail.body.raw_source).to include '111-1111'
        expect(user_sent_mail.body.raw_source).to include '222-2222-2222'
        expect(user_sent_mail.body.raw_source).to include 'テスト県テスト市テスト町1-1-1'
        expect(user_sent_mail.body.raw_source).to include price_unit(order.calc_total_with_tax)

        admin_sent_mail = sent_mails[1]
        expect(admin_sent_mail.subject).to eq "【さくらマーケット】注文がありました(ID:#{order.id})"
        expect(admin_sent_mail.to.first).to eq 'admin@example.com'
        expect(admin_sent_mail.from.first).to eq 'from@example.com'
      end
    end
  end
end
