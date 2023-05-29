require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Game.title }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    price { rand(15.0..99.0) }
    balance { rand(20..60) }
  end
end