class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_cart
    @current_cart ||= CartFactory.session_or_create(session)
  end

  helper_method :current_cart
end
