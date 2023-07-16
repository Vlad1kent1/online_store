class Cart::CartManager
  attr_reader :session, :params
  
  def initialize(session, params)
    @session = session
    @params = params
  end

  def call
    get_product 

    action = params[:action_type].classify
    service = "Cart::#{action}Products".constantize
    service.new(session, get_product).call
  end

  def get_realised_items
    Product.find(session[:products].keys)
  end

  def sum
    get_realised_items.map { |product| session[:products][product.id.to_s] * product.price }.sum
  end

  def product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
  end

  private

  def get_product
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
