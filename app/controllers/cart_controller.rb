class CartController < ApplicationController
  before_action :init_cart, only: %i[update]
  
  def show
    @cart = Cart::CartManager.new(session, params)
  end

  def update
    service = Cart::CartManager.new(session, params).call

    redirect_back fallback_location: root_path, notice: service
  end

  def delete
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def cart_params
    params.permit(:id, :amount, :update_action)
  end

  def init_cart
    session[:products] = {} unless session[:products].present?
  end
end
