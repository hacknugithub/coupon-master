FactoryBot.define do
  factory :user do
    name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    username {"#{Faker::Artist.name}#{Faker::Number.number(digits: 4)}"}
    password {Faker::TvShows::RickAndMorty.location}
    email {Faker::TvShows::RickAndMorty.location.gsub(/\s+/, "") }
  end
end
