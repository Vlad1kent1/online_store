FactoryBot.define do
    factory :product_order do
      product { nil }
      order { nil }
      amount { 1 }
    end
  end