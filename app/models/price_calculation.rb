# frozen_string_literal: true

class PriceCalculation
  def initialize(cash_on_delivery, delivery_price, tax, cart_products)
    @cash_on_delivery = cash_on_delivery
    @delivery_price = delivery_price
    @tax = tax
    @cart_products = cart_products
  end

  def total_without_tax
    @total_without_tax ||= products_price + delivery_price + cash_on_delivery
  end

  def total_with_tax
    @total_with_tax ||= total_without_tax + tax_price
  end

  def products_price
    @products_price ||= @cart_products.sum { |cart_product| cart_product.product.price * cart_product.quantity }
  end

  def products_quantity
    @products_quantity ||= @cart_products.sum(&:quantity)
  end

  def tax_price
    @tax_price ||= (total_without_tax * @tax.rate / 100).floor
  end

  def delivery_price
    quantity = BigDecimal(products_quantity.to_s) / BigDecimal(@delivery_price.per.to_s)
    quantity.ceil * @delivery_price.price
  end

  def cash_on_delivery
    @cash_on_delivery.cash_on_delivery_details.find_by_products_price!(products_price).price
  end
end
