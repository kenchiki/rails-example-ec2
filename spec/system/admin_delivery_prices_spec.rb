require 'rails_helper'

describe 'admin/delivery_prices', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
    FactoryBot.create(:delivery_price, price: 600, per: 5)
  end

  it '#createが正しく動作する' do
    visit new_admin_delivery_price_path
    find('#delivery_price_price').set('700')
    find('#delivery_price_per').set('6')
    find(".edit_delivery_price [type='submit']").click

    delivery_price = DeliveryPrice.order(id: :asc).last
    expect(find('#flash')).to have_content '送料を編集しました'
    expect(delivery_price.price).to eq 700
    expect(delivery_price.per).to eq 6
  end
end
