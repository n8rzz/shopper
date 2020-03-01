# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }
    description { Faker::Food.description }
    prep_time { rand(1..42) }
    cook_time { rand(1..42) }
    yield_value { rand(1..42) }
    yield_unit { %w[servings pounds gallons].sample }

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end

    trait :with_assembly do
      association(:assembly, factory: :assembly)
    end

    trait :without_name do
      name { nil }
    end

    trait :with_recipe_instructions_attributes do
      recipe_instructions_attributes { [ attributes_for(:recipe_instruction) ] }
    end
  end
end
