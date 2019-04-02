FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    city { Faker::TvShows::GameOfThrones.city }
    state { Faker::Movies::StarWars.planet }
  end
end
