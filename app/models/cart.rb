class Cart < ApplicationRecord
  SESSION_KEY = :cart_id

  def self.session_or_create(session)
    cart = find_by(id: session[SESSION_KEY])
    cart.presence || create_empty(session)
  end

  def self.create_empty(session)
    create do |cart|
      session[SESSION_KEY] = cart.id
    end
  end
end
