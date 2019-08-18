FactoryBot.define do
  factory :order do
    status { 'active' }

    location
    shopping_date { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }

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
