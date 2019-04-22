require 'rails_helper'

describe 'admin/delivery_times', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)

    FactoryBot.create(:delivery_time, delivery_time_details_attributes: [{ time: '8時〜12時' }, { time: '12時〜14時' }])
  end

  describe '#create' do
    it '入力項目追加して登録できる' do
      visit new_admin_delivery_time_path

      click_on '入力項目を追加'
      all("[name$='[time]']").last.set('14時〜16時')
      click_on('更新する')

      expect(find('#flash')).to have_content '配送希望時間を編集しました'

      delivery_time = DeliveryTime.order(id: :asc).last
      delivery_time_detail = delivery_time.delivery_time_details.order(id: :asc).last
      expect(delivery_time_detail.time).to eq '14時〜16時'
    end

    it '入力項目削除して登録できる' do
      visit new_admin_delivery_time_path

      all('.remove_fields').last.click
      click_on('更新する')
      expect(find('#flash')).to have_content '配送希望時間を編集しました'

      delivery_time = DeliveryTime.order(id: :asc).last
      delivery_time_detail = delivery_time.delivery_time_details.order(id: :asc).last
      expect(delivery_time.delivery_time_details.count).to eq(1)
      expect(delivery_time_detail.time).to eq '8時〜12時'
    end

    it '入力項目全て空で登録した場合、エラーメッセージが表示される' do
      visit new_admin_delivery_time_path

      all('.remove_fields').last.click
      all('.remove_fields').last.click
      click_on('更新する')

      expect(find('.alert-danger')).to have_content '配送時間は一つ以上入力が必要です'
    end
  end
end
