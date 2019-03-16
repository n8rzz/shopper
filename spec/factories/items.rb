FactoryBot.define do
  factory :item do
    name { Faker::Food.ingredient }

    department
  end
end
