class ProductsController < ApplicationController

  def index
    @products = Product.published.order(position: :asc).page(params[:page])
  end
end
