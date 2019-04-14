class CartProductsController < ApplicationController
  before_action :set_product, only: %i[new create]
  before_action :set_cart_product, only: %i[edit update destroy]

  def index
    @cart_products = current_cart.cart_products.order(created_at: :desc)
  end

  def show
  end

  def new
    @cart_product = @product.cart_products.build(cart: current_cart)
  end

  def edit
  end

  def create
    @cart_product = @product.cart_products.build(cart_product_params)
    @cart_product.cart = current_cart

    if @cart_product.save
      redirect_to cart_products_path, notice: 'カートの商品を追加しました。'
    else
      render :new
    end
  end

  def update
    if @cart_product.update(cart_product_params)
      redirect_to cart_products_url, notice: 'カートの商品を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @cart_product.destroy!
    redirect_to cart_products_url, notice: 'カートの商品を削除しました。'
  end

  private

  def set_cart_product
    @cart_product = current_cart.cart_products.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def cart_product_params
    params.require(:cart_product).permit(:quantity)
  end
end
