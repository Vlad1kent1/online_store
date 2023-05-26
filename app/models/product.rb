class Product < ApplicationRecord
    has_many :product_orders, dependent: :destroy
    has_many :orders, through: :product_orders

    validates :name, :description, presence: true
    validates :price, numericality: { greater_than: 0 }
end
