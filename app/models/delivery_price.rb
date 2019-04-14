class DeliveryPrice < ApplicationRecord
  validates :price, :per, presence: true
end
