class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
  has_one :last_shipping_address, -> { order(id: :desc) }, class_name: :ShippingAddress
  delegate :full_name, :tel, :post, :address, to: :last_shipping_address, allow_nil: true
end
