class Cart::UpdateAmount < ApplicationService
  attr_reader :current_session, :params, :product, :product_balance

  def initialize(current_session, params = {})
    @current_session = current_session
    @params = params
  end

  def call
    set_product

    current_session[:products][product[:id]] = product[:amount]
    current_session[:products]
  end

  private

  def set_product
    @product = {
      id: params[:id],
      amount: params[:amount].to_i
    }

    @product_balance = Product.find(product[:id].to_i).balance

    product[:amount] = 1 if product[:amount].blank? || product[:amount] <= 0
    product[:amount] = product_balance if product_balance < product[:amount]
  end
end
