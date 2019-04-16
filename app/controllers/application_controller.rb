class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_cart
    @current_cart ||= Cart.session_or_create(session)
  end

  def new_cart
    @current_cart = Cart.create_empty(session)
  end

  helper_method :current_cart
end
