class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  SESSION_KEY = :cart_id

  def self.session_or_create(session)
    cart = find_by(id: session[SESSION_KEY])
    cart.presence || create_empty(session)
  end

  def self.create_empty(session)
    create.tap do |cart|
      session[SESSION_KEY] = cart.id
    end
  end

  def total_without_tax
    @total_without_tax ||= products_price + delivery_price + cash_on_delivery
  end

  def total_with_tax
    @total_with_tax ||= total_without_tax + tax_price
  end

  def products_price
    @products_price ||= cart_products.sum(&:subtotal)
  end

  def products_quantity
    @products_quantity ||= cart_products.sum(&:quantity)
  end

  def tax_price
    tax = Tax.order(id: :asc).last
    @tax_price ||= (total_without_tax * tax.rate / 100).floor
  end

  def delivery_price
    delivery_price = DeliveryPrice.order(id: :asc).last
    quantity = BigDecimal(products_quantity.to_s) / BigDecimal(delivery_price.per.to_s)
    quantity.ceil * delivery_price.price
  end

  def cash_on_delivery
    cash_on_delivery = CashOnDelivery.order(id: :asc).last
    cash_on_delivery.cash_on_delivery_details.find_by_products_price!(products_price).price
  end
end
