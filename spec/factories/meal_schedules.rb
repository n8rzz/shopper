FactoryBot.define do
  factory :meal_schedule do
    schedule_date { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    purchased { false }
    meal_time { ['morning', 'afternoon', 'evening', 'none'].sample }

    order_item { nil}
    assembly { nil }
    item { nil}

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end

    trait :with_item do
      association :item
    end

    trait :with_order_item do
      association :order_item
    end

    trait :with_assembly do
      association :assembly
    end
  end
end
