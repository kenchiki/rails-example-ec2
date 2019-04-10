class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  scope :published, -> { where(published: true) }
end
