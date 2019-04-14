FactoryBot.define do
  factory :assembly do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }

    trait :with_item do
      after(:create) do |assembly|
        assembly.assembly_items << create(:assembly_item)
      end
    end
  end
end
