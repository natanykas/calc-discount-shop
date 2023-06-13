FactoryBot.define do
  factory :discount do
    quantity { Faker::Number.number }
    percentage { Faker::Number.between(from: 5, to: 30) }
  end
end
