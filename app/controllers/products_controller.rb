class ProductsController < ApplicationController

  def index
    @products = Product.published.order(id: :desc)
  end
end
