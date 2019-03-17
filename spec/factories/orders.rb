FactoryBot.define do
  factory :order do
    status { 'active' }

    location

    trait :pending do
      status { 'pending' }
    end

    # trait :with_order_items do
    #   after(:create) do |order|
    #     order.order_items << create(:order_item)
    #   end
    # end
  end
end
