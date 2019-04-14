FactoryBot.define do
  factory :order_item do
    picked { false }
    qty { rand(1..5) }

    order
    department
    item

    trait :with_assembly do
      assembly
    end
  end
end
