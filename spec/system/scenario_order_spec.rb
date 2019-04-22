require 'rails_helper'

describe '注文', type: :system do
  let!(:product) { FactoryBot.create(:product) }
  let(:user) { FactoryBot.create(:user, :with_deliver_info) }

  before do
    sign_in user

    FactoryBot.create(:tax)
    FactoryBot.create(:cash_on_delivery)
    FactoryBot.create(:delivery_price)
    FactoryBot.create(:delivery_time)
  end

  it 'カートに商品を入れて、注文できる' do
    visit products_path
    expect(page).to have_selector 'h1', text: '商品一覧'

    find_link(href: new_product_cart_product_path(product)).click
    expect(page).to have_selector 'h1', text: '商品詳細'

    click_on('追加する')
    expect(find('#flash')).to have_content 'カートの商品を追加しました'
    expect(current_path).to eq cart_products_path

    click_on('注文確認に進む')
    expect(page).to have_selector 'h1', text: '注文確認'
    expect(current_path).to eq new_my_order_path

    click_on('購入を確定する')
    expect(page).to have_selector 'h1', text: '注文詳細'
    expect(find('#flash')).to have_content '注文が完了しました'

    order = Order.order(id: :asc).last
    expect(current_path).to eq my_order_path(order)
  end
end
