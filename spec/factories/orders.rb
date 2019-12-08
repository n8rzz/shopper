FactoryBot.define do
  factory :order do
    status { 'active' }

    location
    shopping_date { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end

    trait :pending do
      status { 'pending' }
    end

    trait :cancelled do
      status { 'cancelled' }
    end

    trait :complete do
      status { 'complete' }
    end

    trait :with_order_items do
      after(:create) do |order|
        order.order_items << create(:order_item, :with_assembly)
      end
    end
  end
end
