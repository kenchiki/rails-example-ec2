class CashOnDeliveryDetail < ApplicationRecord
  belongs_to :cash_on_delivery
  validates :price, :more_than, presence: true
end
