FactoryBot.define do
  factory :product_order do
    product
    order
    amount { 1 }
  end
end
