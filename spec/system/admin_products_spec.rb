require 'rails_helper'

describe 'admin/products', type: :system do
  before do
    sign_in FactoryBot.create(:user, :with_admin)
  end

  it '#create（商品が追加できる）' do
    visit new_admin_product_path
    find('#product_name').set('name1')
    find('#product_price').set('100')
    find('#product_description').set('description1')
    find(".new_product [type='submit']").click

    product = Product.order(id: :asc).last
    expect(product.name).to eq 'name1'
    expect(product.price).to eq 100
    expect(product.description).to eq 'description1'
  end

  it '#update（商品が編集できる）' do
    product = FactoryBot.create(:product)

    visit edit_admin_product_path(product)
    find('#product_name').set('name2')
    find('#product_price').set('200')
    find('#product_description').set('description2')
    find(".edit_product [type='submit']").click
    expect(find('#flash')).to have_content '商品を編集しました'

    product.reload
    expect(product.name).to eq 'name2'
    expect(product.price).to eq 200
    expect(product.description).to eq 'description2'
  end

  it '#destroy（商品が削除できる）' do
    product = FactoryBot.create(:product)

    visit admin_products_path
    expect do
      accept_confirm do
        find("[data-method='delete'][href='#{admin_product_path(product)}']").click
      end
      expect(find('#flash')).to have_content '商品を削除しました'
    end.to change(Product, :count).by(-1)
  end

  describe '並び替えができる' do
    let!(:product1) { FactoryBot.create(:product, name: 'product1') }
    let!(:product2) { FactoryBot.create(:product, name: 'product2') }
    let!(:product3) { FactoryBot.create(:product, name: 'product3') }

    it '#sort_up（一つ上に移動できる）' do
      visit admin_products_path

      expect do
        find_link(href: sort_up_admin_product_path(product2)).click
        expect(find('#flash')).to have_content '商品を一つ上に移動しました'
      end.to change {
        Product.order(position: :asc).to_a
      }.from([product3, product2, product1]).to([product2, product3, product1])
    end

    it '#sort_down（一つ下に移動できる）' do
      visit admin_products_path

      expect do
        find_link(href: sort_down_admin_product_path(product3)).click
        expect(find('#flash')).to have_content '商品を一つ下に移動しました'
      end.to change {
        Product.order(position: :asc).to_a
      }.from([product3, product2, product1]).to([product2, product3, product1])
    end

    it '#sort_top（一番上に移動できる）' do
      visit admin_products_path

      expect do
        accept_confirm do
          find_link(href: sort_top_admin_product_path(product1)).click
        end
        expect(find('#flash')).to have_content '商品を一番上に移動しました'
      end.to change {
        Product.order(position: :asc).to_a
      }.from([product3, product2, product1]).to([product1, product3, product2])
    end

    it '#sort_bottom（一番下に移動できる）' do
      visit admin_products_path

      expect do
        accept_confirm do
          find_link(href: sort_bottom_admin_product_path(product3)).click
        end
        expect(find('#flash')).to have_content '商品を一番下に移動しました'
      end.to change {
        Product.order(position: :asc).to_a
      }.from([product3, product2, product1]).to([product2, product1, product3])
    end
  end
end
