FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    city { Faker::TvShows::GameOfThrones.city }
    state { Faker::Movies::StarWars.planet }

    ownable_user

    trait :ownable_group do
      association(:ownable, factory: :group)
    end

    trait :ownable_user do
      association(:ownable, factory: :user)
    end
  end
end
