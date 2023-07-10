class Cart::UpdateProducts
  attr_reader :session, :product

  def initialize(session, product)
    @session = session
    @product = product
  end

  def call
    session[:products][product[:id]] = product[:amount]
    
    "Amount was updated"
  end
end
