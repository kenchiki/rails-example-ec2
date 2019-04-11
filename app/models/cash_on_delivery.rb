class CashOnDelivery < ApplicationRecord
  has_many :cash_on_delivery_details, -> { order(more_than: :asc) },
           dependent: :destroy, inverse_of: :cash_on_delivery
  accepts_nested_attributes_for :cash_on_delivery_details
end
