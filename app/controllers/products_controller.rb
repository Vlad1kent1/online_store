class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :balance)
  end
end
