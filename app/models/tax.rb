class Tax < ApplicationRecord
  validates :rate, presence: true
end
