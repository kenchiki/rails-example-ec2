class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  MAX_QUANTITY = 20

  validates :quantity, presence: true

  before_create :sum_quantity, :adjust_quantity
  before_update :adjust_quantity

  private

  def sum_quantity
    cart_products = cart.cart_products.where(product: product)
    return unless cart_products.exists?

    sum = cart_products.pluck(:quantity).sum
    self.quantity += sum
    cart_products.destroy_all
    raise '商品の個数をまとめられませんでした' unless cart_products.all?(&:destroyed?)
  end

  def adjust_quantity
    self.quantity = self.quantity > MAX_QUANTITY ? MAX_QUANTITY : self.quantity
  end
end
