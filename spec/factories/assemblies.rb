FactoryBot.define do
  factory :assembly do
    name { Faker::Food.dish }
  end
end
