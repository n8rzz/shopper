FactoryBot.define do
  factory :user do
    sequence :username do |n|
        "#{Faker::Movies::StarWars.character}-#{n}"
    end

    sequence :email do |n|
        "test-#{n}@example.com"
    end

    password {"123456"}
  end
end
