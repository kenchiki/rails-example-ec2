class ApplicationController < ActionController::Base
  helper_method :current_cart

  before_action :basic_authentication, :authenticate_user!

  private

  def current_cart
    @current_cart ||= Cart.session_or_create(session)
  end

  def new_cart
    @current_cart = Cart.create_empty(session)
  end

  def basic_authentication
    return unless Rails.env.production?
    basic_auth_username = ENV['BASIC_AUTH_USERNAME']
    basic_auth_password = ENV['BASIC_AUTH_PASSWORD']
    return if basic_auth_username.nil? || basic_auth_password.nil?
    self.class.http_basic_authenticate_with name: basic_auth_username, password: basic_auth_password
  end
end
