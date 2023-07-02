class CartController < ApplicationController
  before_action :init_cart, only: :update
  
  def index
    @cart = Cart::CartManager.new(session, params)
  end

  def update
    service = Cart::CartManager.new(session, cart_params)
    service.call

    redirect_back fallback_location: root_path, notice: service
  end

  def destroy
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def cart_params
    params.permit(:id, :amount, :action_type)
  end

  def init_cart
    session[:products] = {} unless session[:products].present?
  end
end
