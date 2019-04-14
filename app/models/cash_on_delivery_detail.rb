class CashOnDeliveryDetail < ApplicationRecord
  belongs_to :cash_on_delivery
  validates :price, :more_than, presence: true

  def self.find_by_products_price!(products_price)
    order(id: :asc).where('more_than <= ?', products_price).last!
  end
end
