# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_instruction do
    sequence(:sort_order)
    text { Faker::Food.description }

    association :recipe
  end
end
