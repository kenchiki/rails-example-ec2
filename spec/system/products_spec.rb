require 'rails_helper'

describe 'products', type: :system do
  let!(:published_product) { FactoryBot.create(:product, published: true) }
  let!(:unpublished_product) { FactoryBot.create(:product, published: false) }

  describe '#index' do
    it '公開中の商品は一覧に表示される' do
      visit products_path

      expect(find('#container')).to have_link href: new_product_cart_product_path(published_product)
    end

    it '非公開の商品は一覧に表示されない' do
      visit products_path

      expect(find('#container')).to have_no_link href: new_product_cart_product_path(unpublished_product)
    end
  end

  describe '#show' do
    it '公開中の商品は表示できる' do
      visit new_product_cart_product_path(published_product)

      expect(current_path).to eq new_product_cart_product_path(published_product)
    end

    it '非公開の商品は表示できない' do
      visit new_product_cart_product_path(unpublished_product)

      expect(current_path).to eq products_path
    end
  end
end
