FactoryBot.define do
  factory :order_item do
    picked { false }

    order
    department
    item
    assembly
  end
end
