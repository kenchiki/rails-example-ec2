class Order < ApplicationRecord
  belongs_to :cash_on_delivery
  belongs_to :delivery_price
  belongs_to :tax
  belongs_to :user
  belongs_to :cart
  belongs_to :delivery_time_detail
  has_many :order_details, dependent: :destroy
  delegate :calc_total_without_tax, :calc_total_with_tax, :calc_products_price, :calc_products_quantity,
           :calc_tax_price, :calc_delivery_price, :calc_cash_on_delivery, to: :price_calculation
  before_validation :set_relations, :set_params, :build_order_details

  def set_relations
    self.tax = Tax.order(id: :asc).last
    self.cash_on_delivery = CashOnDelivery.order(id: :asc).last
    self.delivery_price = DeliveryPrice.order(id: :asc).last
  end

  def set_params
    self.full_name = user.full_name
    self.post = user.post
    self.tel = user.tel
    self.address = user.address
    self.total_with_tax = cart.calc_total_with_tax
  end

  def build_order_details
    cart.cart_products.each do |cart_product|
      order_detail = order_details.build
      order_detail.price = cart_product.price
      order_detail.quantity = cart_product.quantity
      order_detail.product = cart_product.product
    end
  end

  def price_calculation
    PriceCalculation.new(cash_on_delivery, delivery_price, tax, order_details)
  end
end
