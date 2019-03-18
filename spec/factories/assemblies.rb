FactoryBot.define do
  factory :assembly do
    name { Faker::Food.dish }

    trait :with_item do
      after(:create) do |assembly|
        assembly.assembly_items << create(:assembly_item)
      end
    end
  end
end
