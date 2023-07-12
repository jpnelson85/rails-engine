FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.within(range: 1..1000) }
    # unit_price { Faker::Commerce.price }
  end
end