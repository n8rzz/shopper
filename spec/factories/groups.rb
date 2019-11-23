FactoryBot.define do
  factory :group do
    name { Faker::Company.industry }
    description { Faker::Company.bs }
  end
end
