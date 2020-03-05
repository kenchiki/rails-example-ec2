require 'rails_helper'

describe 'admin/cash_on_deliveries', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)

    FactoryBot.create(:cash_on_delivery, cash_on_delivery_details_attributes: [
      { price: 300, more_than: 0 },
      { price: 400, more_than: 10000 }
    ])
  end

  describe '#create' do
    it '入力項目追加して登録できる' do
      visit new_admin_cash_on_delivery_path

      click_on '入力項目を追加'
      all("[name$='[price]']").last.set('500')
      all("[name$='[more_than]']").last.set('20000')
      click_on('更新する')

      expect(find('#flash')).to have_content '代引き手数料を編集しました'

      cash_on_delivery = CashOnDelivery.order(id: :asc).last
      cash_on_delivery_detail = cash_on_delivery.cash_on_delivery_details.order(id: :asc).last
      expect(cash_on_delivery_detail.price).to eq 500
      expect(cash_on_delivery_detail.more_than).to eq 20000
    end

    it '入力項目削除して登録できる' do
      visit new_admin_cash_on_delivery_path

      all('.remove_fields').last.click
      click_on('更新する')

      expect(find('#flash')).to have_content '代引き手数料を編集しました'

      cash_on_delivery = CashOnDelivery.order(id: :asc).last
      cash_on_delivery_detail = cash_on_delivery.cash_on_delivery_details.order(id: :asc).last
      expect(cash_on_delivery.cash_on_delivery_details.count).to eq(1)
      expect(cash_on_delivery_detail.price).to eq 300
      expect(cash_on_delivery_detail.more_than).to eq 0
    end

    it '購入金額が0円の入力項目がない場合、エラーメッセージが表示される' do
      visit new_admin_cash_on_delivery_path

      all('.remove_fields').last.click
      all('.remove_fields').last.click
      click_on('更新する')

      expect(find('#container')).to have_content '購入金額0円以上を一つ含む必要があります'
    end
  end
end
