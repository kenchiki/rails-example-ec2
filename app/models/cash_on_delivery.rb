class CashOnDelivery < ApplicationRecord
  has_many :cash_on_delivery_details, -> { order(more_than: :asc) },
           dependent: :destroy, inverse_of: :cash_on_delivery
  accepts_nested_attributes_for :cash_on_delivery_details, allow_destroy: true, reject_if: :all_blank

  validate ->(cash_on_delivery) {
    unless cash_on_delivery.cash_on_delivery_details.any? { |detail| detail.more_than.zero? }
      errors.add(:base, '購入金額が0円を一つ含む必要があります')
    end
  }
end
