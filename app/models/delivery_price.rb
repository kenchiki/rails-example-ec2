class DeliveryPrice < ApplicationRecord
  validates :price, :fee, presence: true
end
