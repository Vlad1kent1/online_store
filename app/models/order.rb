class Order < ApplicationRecord
    has_many :product_orders, dependent: :destroy
    has_many :products, through: :product_orders

    validates :firstname, :lastname, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Must have only letters" }
    validates :address, :phone, presence: true
end
