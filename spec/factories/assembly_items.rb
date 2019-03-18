FactoryBot.define do
  factory :assembly_item do
    qty { rand(1..100) }

    assembly
    item
  end
end
