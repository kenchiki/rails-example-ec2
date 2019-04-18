class ShippingAddress < ApplicationRecord
  belongs_to :user
  validates :full_name, :post, :tel, :address, presence: true
end
