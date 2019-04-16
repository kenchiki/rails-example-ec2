class DeliveryTime < ApplicationRecord
  has_many :delivery_time_details, dependent: :destroy
  accepts_nested_attributes_for :delivery_time_details, reject_if: all
end
