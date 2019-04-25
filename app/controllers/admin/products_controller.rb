class Admin::ProductsController < Admin::AdministratorController
  before_action :set_product, only: %i[show edit update destroy sort_up sort_down sort_top sort_bottom]

  def index
    @products = Product.order(position: :asc).page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, @product], notice: '商品を追加しました'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to [:admin, @product], notice: '商品を編集しました'
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_products_url, notice: '商品を削除しました'
    else
      redirect_to admin_products_url, alert: @product.errors[:base].to_sentence
    end
  end

  def sort_up
    @product.move_higher
    redirect_to admin_products_url, notice: '商品を一つ上に移動しました'
  end

  def sort_down
    @product.move_lower
    redirect_to admin_products_url, notice: '商品を一つ下に移動しました'
  end

  def sort_top
    @product.move_to_top
    redirect_to admin_products_url, notice: '商品を一番上に移動しました'
  end

  def sort_bottom
    @product.move_to_bottom
    redirect_to admin_products_url, notice: '商品を一番下に移動しました'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :image, :price, :description, :published, :position, :remove_image)
  end
end
