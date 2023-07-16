FactoryBot.define do
  factory :product_order do
    product
    order
    amount { Faker::Number.digit }
  end
end
