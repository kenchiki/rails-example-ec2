class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy, inverse_of: :user
  has_one :last_shipping_address, -> { order(id: :desc) }, class_name: :ShippingAddress

  accepts_nested_attributes_for :shipping_addresses
  delegate :full_name, :tel, :post, :address, to: :last_shipping_address, allow_nil: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true

  def shipping_addresses_attributes=(shipping_addresses)
    shipping_addresses.each do |_, attr|
      self.shipping_addresses.build(attr)
    end
  end
end
