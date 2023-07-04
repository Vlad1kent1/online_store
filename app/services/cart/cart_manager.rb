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
    product = Product.find(params[:id])

    return if product.nil?

    params[:amount] = 1 if params[:amount].blank?

    params[:amount] = product.balance if product.balance < params[:amount].to_i

    {
      id: params[:id],
      amount: params[:amount].to_i,
      balance: product.balance
    }
  end
end
