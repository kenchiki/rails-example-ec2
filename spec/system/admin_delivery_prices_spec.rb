require 'rails_helper'

describe 'admin/delivery_prices', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
    FactoryBot.create(:delivery_price, price: 600, per: 5)
  end

  it '#new（最後に登録された送料がフォームに初期値として反映されている）' do
    visit new_admin_delivery_price_path

    expect(page).to have_field 'delivery_price[price]', with: '600'
    expect(page).to have_field 'delivery_price[per]', with: '5'
  end

  it '#create（送料が編集できる）' do
    visit new_admin_delivery_price_path

    find_field('delivery_price[price]').set('700')
    find_field('delivery_price[per]').set('6')
    click_on('更新する')

    expect(find('#flash')).to have_content '送料を編集しました'

    delivery_price = DeliveryPrice.order(id: :asc).last
    expect(delivery_price.price).to eq 700
    expect(delivery_price.per).to eq 6
  end
end
