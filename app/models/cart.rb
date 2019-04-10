class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  SESSION_KEY = :cart_id

  def self.session_or_create(session)
    cart = find_by(id: session[SESSION_KEY])
    cart.presence || create_empty(session)
  end

  def self.create_empty(session)
    create.tap do |cart|
      session[SESSION_KEY] = cart.id
    end
  end
end
