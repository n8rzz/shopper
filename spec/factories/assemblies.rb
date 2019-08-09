FactoryBot.define do
  factory :assembly do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }

    trait :with_item do
      after(:create) do |assembly|
        item = create(:item)

        assembly.assembly_items.new({ id: item.id, qty: rand(1..10) })
      end
    end
  end
end
