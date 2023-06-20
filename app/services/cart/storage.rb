class Cart::Storage
  attr_reader :current_session, :params

  def initialize(current_session, params = {})
    @current_session = current_session
    @params = params
  end

  def products
    current_session[:products].keys.map { |id| Product.find(id) }
  end

  def sum
    products.map { |product| current_session[:products][product.id.to_s] * product.price }.sum
  end
end
