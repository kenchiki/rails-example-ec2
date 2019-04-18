class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :restrict_with_error
  scope :published, -> { where(published: true) }
  validates :name, :price, :description, presence: true
  acts_as_list add_new_at: :top
end
