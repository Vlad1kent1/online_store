class Orders::OrderManager

  def initialize(products_hash, order, current_session)
    @products_hash = products_hash
    @order = order
    @current_session = current_session
  end

  def call
    @products_hash.each do |product_id, amount|
      product = Product.find(product_id)
      amount = [amount, product.balance].min

      @order.product_orders.create(product_id:, amount:)
    end

    @order.products.each do |product|
      product.update(balance: product.balance - product.product_orders.where(order_id: @order.id).sum(:amount))
    end

    @current_session.delete(:products)
  end
end
