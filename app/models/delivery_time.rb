class DeliveryTime < ApplicationRecord
  has_many :delivery_time_details, dependent: :destroy
  accepts_nested_attributes_for :delivery_time_details, allow_destroy: true, reject_if: :all_blank

  validate ->(delivery_time) {
    if delivery_time.delivery_time_details.empty?
      errors.add(:base, '配送時間は一つ以上入力が必要です')
    end
  }
end
