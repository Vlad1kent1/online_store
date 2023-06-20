class CartController < ApplicationController
  def show
    return unless session[:products]

    cart = Cart::Storage.new(session, params)

    @session_products = cart.products
    @session_sum = cart.sum
  end

  def create
    session[:products] = {}
  end

  def update
    create unless session[:products].present?

    modify_product
  end

  def delete
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def modify_product
    case cart_params[:update_action]

    when 'buy'
      Cart::AddProduct.call(session, params)
      redirect_to products_path, notice: "Product was added to cart."

    when 'change'
      Cart::UpdateAmount.call(session, params)
      redirect_to cart_path, notice: "Amount was changed"

    when 'delete'
      Cart::RemoveProduct.call(session, params)
      
      redirect_to cart_path, notice: "Product was removed" and return if session[:products].present?
      delete if session[:products].empty?
    end
  end

  def cart_params
    params.permit(:id, :amount, :update_action)
  end
end
