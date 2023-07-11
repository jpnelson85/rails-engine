require 'rails_helper'

FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end