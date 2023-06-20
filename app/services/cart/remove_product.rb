class Cart::RemoveProduct < ApplicationService
  attr_reader :current_session, :params, :product, :product_balance

  def initialize(current_session, params = {})
    @current_session = current_session
    @params = params
  end

  def call
    current_session[:products].delete(params[:id])
    current_session[:products]
  end
end
