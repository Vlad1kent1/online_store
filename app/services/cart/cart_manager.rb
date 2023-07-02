class Cart::CartManager
  attr_reader :session, :params
  attr_accessor :notice

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def call
    set_product 

    service = "Cart::#{params[:action_type].classify}Products".constantize
    service.new(session, set_product).call
  end

  def items
    Product.find(session[:products].keys)
  end

  def sum
    items.map { |product| session[:products][product.id.to_s] * product.price }.sum
  end

  def product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
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
  
    product
  end
end
