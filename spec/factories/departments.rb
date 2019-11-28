FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "#{Faker::Commerce.department}-#{n}" }

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end
  end
end
