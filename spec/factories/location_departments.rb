FactoryBot.define do
  factory :location_department do
    sequence(:sort_order)

    location
    department
  end
end
