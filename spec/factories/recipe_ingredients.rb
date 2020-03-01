FactoryBot.define do
  factory :recipe_ingredient do
    sequence(:name) {|n| "#{Faker::Food.ingredient}-#{n}" }
    qty_value { rand(1..42) }
    qty_unit { Faker::Measurement.metric_volume }

    association :recipe

    trait :with_item do
      association :item
    end
  end
end
