class Cart::AddProducts < ApplicationService
  attr_reader :session, :product
  attr_accessor :notice

  def initialize(session, product)
    @session = session
    @product = product
  end

  def call
    if session[:products].key?(product[:id])
      session[:products][product[:id]] = available_amount
    else
      @session[:products].merge!(product[:id] => product[:amount])
    end
  end

  private

  def available_amount
    desired_amount = product[:amount] + session.dig(:products, product[:id])

    # check if desired amount isn't greater than balance + already shipped amount
    [product[:balance], desired_amount].min
  end
end
