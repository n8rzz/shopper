FactoryBot.define do
  factory :assembly_item do
    qty { rand(1..10000) }

    association :assembly
    association :item
  end
end
