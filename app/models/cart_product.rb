class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  delegate :name, :price, to: :product
  MAX_QUANTITY = 20

  before_create :sum_quantity, :adjust_quantity
  before_update :adjust_quantity

  private

  def sum_quantity
    return unless product.cart_products.exists?

    sum = product.cart_products.pluck(:quantity).sum
    self.quantity += sum
    product.cart_products.destroy_all
    raise '商品の個数をまとめられませんでした' unless product.cart_products.all?(&:destroyed?)
  end

  def adjust_quantity
    self.quantity = self.quantity > MAX_QUANTITY ? MAX_QUANTITY : self.quantity
  end
end
