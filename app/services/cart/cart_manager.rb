class Cart::CartManager
  attr_reader :session, :params, :product, :product_balance
  attr_accessor :notice

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def call
    case params[:update_action]

    when 'buy'
      add_products
      "Product was added to cart."

    when 'change'
      update_products
      "Amount was changed"

    when 'delete'
      delete_products
      "Product was removed"
    end
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

  def add_products
    set_product

    if session[:products].key?(product[:id])
      if amount_greater_balance?
        session[:products][product[:id]] = product_balance
      else
        session[:products][product[:id]] += product[:amount]
      end
    else
      @session[:products].merge!(product[:id] => product[:amount])
    end
  end

  def update_products
    set_product

    session[:products][product[:id]] = product[:amount]
  end

  def delete_products
    session[:products].delete(params[:id])
  end

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
