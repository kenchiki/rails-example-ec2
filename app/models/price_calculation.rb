# frozen_string_literal: true

class PriceCalculation
  def initialize(cash_on_delivery, delivery_price, tax, cart_products)
    @cash_on_delivery = cash_on_delivery
    @delivery_price = delivery_price
    @tax = tax
    @cart_products = cart_products
  end

  def calc_total_without_tax
    @calc_total_without_tax ||= calc_products_price + calc_delivery_price + calc_cash_on_delivery
  end

  def calc_total_with_tax
    @calc_total_with_tax ||= calc_total_without_tax + calc_tax_price
  end

  def calc_products_price
    @calc_products_price ||= @cart_products.sum { |cart_product| cart_product.price * cart_product.quantity }
  end

  def calc_products_quantity
    @calc_products_quantity ||= @cart_products.sum(&:quantity)
  end

  def calc_tax_price
    @calc_tax_price ||= (calc_total_without_tax * @tax.rate / 100).floor
  end

  def calc_delivery_price
    quantity = BigDecimal(calc_products_quantity.to_s) / BigDecimal(@delivery_price.per.to_s)
    quantity.ceil * @delivery_price.price
  end

  def calc_cash_on_delivery
    @cash_on_delivery.cash_on_delivery_details.find_by_products_price!(calc_products_price).price
  end
end
