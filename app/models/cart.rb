class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :orders, dependent: :destroy
  SESSION_KEY = :cart_id
  delegate :calc_total_without_tax, :calc_total_with_tax, :calc_products_price, :calc_products_quantity,
           :calc_tax_price, :calc_delivery_price, :calc_cash_on_delivery, to: :price_calculation

  def self.session_or_create(session)
    cart = find_by(id: session[SESSION_KEY])
    cart.presence || create_empty(session)
  end

  def self.create_empty(session)
    create.tap do |cart|
      session[SESSION_KEY] = cart.id
    end
  end

  def price_calculation
    cash_on_delivery = CashOnDelivery.order(id: :asc).last
    delivery_price = DeliveryPrice.order(id: :asc).last
    tax = Tax.order(id: :asc).last

    PriceCalculation.new(cash_on_delivery, delivery_price, tax, cart_products)
  end
end
