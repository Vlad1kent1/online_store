class Product < ApplicationRecord
    has_many :product_orders, dependent: :destroy
    has_many :orders, through: :product_orders
  
    validates :name, :description, presence: true
    validates :price, :balance, numericality: { greater_than_or_equal_to: 0 }
  end
