class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :restrict_with_error

  acts_as_list add_new_at: :top
  mount_uploader :image, ProductImageUploader

  validates :name, :price, :description, presence: true

  scope :published, -> { where(published: true) }
end
