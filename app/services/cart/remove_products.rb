class Cart::RemoveProducts
  attr_reader :session, :product

  def initialize(session, product)
    @session = session
    @product = product
  end

  def call
    session[:products].delete(params[:id])

    "Product was removed"
  end
end
