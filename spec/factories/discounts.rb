# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    quantity { Faker::Number.number(digits: 2) }
    percentage { Faker::Number.between(from: 5, to: 30) }
  end
end
