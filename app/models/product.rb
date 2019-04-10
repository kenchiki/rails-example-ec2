class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  has_many :cart_products, dependent: :destroy

  scope :published, -> { where(published: true) }
end