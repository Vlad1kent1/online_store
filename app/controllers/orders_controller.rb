class OrdersController < ApplicationController
  before_action :check_cart, only: [:new, :create]
  attr_accessor :notice, :alert

  def show
    @order = resourse
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      service = Orders::OrderManager.new(session[:products], @order, session).call

      if service 
        flash.notice = "Order was succesfully created"
      else
        flash.alert = "Something went wrong"
      end

      redirect_to order_path(@order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def collection
    Order.ordered
  end

  def resourse
    collection.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def check_cart
    redirect_to products_path if session[:products].blank?

    @session_manager = Cart::CartManager.new(session, params)
  end
end
