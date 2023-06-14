# frozen_string_literal: true

FactoryBot.define do
  factory :exception_collection do
    name { Faker::Commerce.brand }
  end
end
