FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "#{Faker::Food.ingredient}-n" }

    department
  end
end
