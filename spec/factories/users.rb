FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "#{Faker::Movies::StarWars.character}-#{n}"
    end

    sequence :email do |n|
      "test-#{n}@example.com"
    end

    password {"123456"}
    confirmed_at { DateTime.now }

    trait :without_confirmed_at do
      confirmed_at { nil }
    end

    trait :with_group_invitation do
      invitation_group_id { 1 }
      invitation_group_token { '7minuteabs' }
      invitation_sent_at { DateTime.now }
    end
  end
end
