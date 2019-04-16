class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :full_name, :post, :tel, :address, presence: true, on: :update
  has_many :orders, dependent: :destroy
end
