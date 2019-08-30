FactoryBot.define do
  factory :assembly do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }

    trait :with_item do
      after(:create) do |assembly|
        create(:assembly_item, item_id: create(:item).id, assembly_id: assembly.id)
      end
    end

    trait :with_items do
      transient do
        items_count { 2 }
      end

      after(:create) do |assembly, evaluator|
        evaluator.items_count.times do
          create(:assembly_item, item_id: create(:item).id, assembly_id: assembly.id)
        end
      end
    end
  end
end
