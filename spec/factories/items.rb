FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "#{Faker::Food.ingredient}-n" }

    department

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end
  end
end
