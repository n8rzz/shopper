FactoryBot.define do
  factory :assembly do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }

    trait :with_item do
      after(:create) do |assembly|
        item = create(:item)

        create(:assembly_item, item_id: item.id, assembly_id: assembly.id)
      end
    end

    # FIXME: use `transient` here instead
    trait :with_two_items do
      after(:create) do |assembly|
        2.times do
          create(:assembly_item, item_id: create(:item).id, assembly_id: assembly.id)
        end
      end
    end
  end
end
