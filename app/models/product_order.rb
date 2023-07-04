class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :amount, numericality: { greater_than: 0 }
end
