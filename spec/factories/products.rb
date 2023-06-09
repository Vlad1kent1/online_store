require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Game.title }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    price { Faker::Number.decimal(l_digits: 4, r_digits: 2)  }
    balance { Faker::Number.digit }
  end
end
