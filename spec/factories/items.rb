require 'rails_helper'

FactoryBot.define do
  factory :items do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
  end
end